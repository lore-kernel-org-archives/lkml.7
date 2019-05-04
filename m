Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F847C43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 12:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16990206A3
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 12:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556974336;
	bh=ocmVBxXdJfg2gyO/W1vrYfsByp/BJCuhp1N6gsC4auk=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=OmAh7GkEfeeNxBl5ganyPgyhXJeZTUPvCViKoFupRl3Ul/juBeXT+k0Lc/kQOiCJc
	 dnMPxAKX6G0KxHZ3DNx8OMnAQlBy7srUAuRl041LPbDIg615N1eZbtBBVf8dxnzWKn
	 cARe6K+ReZBfImDha8gE8nNqMjPK/I+gKbmXqxk4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbfEDMwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 08:52:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53904 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726672AbfEDMwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 08:52:10 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B6866308339A;
        Sat,  4 May 2019 12:52:09 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0F1AB5C298;
        Sat,  4 May 2019 12:52:07 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [RFC 0/8] perf/x86: Add update attribute groups
Date:   Sat,  4 May 2019 14:51:59 +0200
Message-Id: <20190504125207.24662-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Sat, 04 May 2019 12:52:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
following up on [1], this patchset adds update attribute groups
to pmu and gets rid of the 'creative' attribute handling code.

In x86 pmu we mainly add attributes into following directories:
  events, format, caps

so it seems like we could have just 3 attribute groups, but most of
the attributes presence depends on HW, which ends up with attributes
merging and all that 'creative' code we have now.

Currently, we have 'struct pmu::attr_groups', which is in its final
shape (merged) and it's added via sysfs_create_groups call when
registering the pmu:

  perf_pmu_register
    pmu_dev_alloc
      device_add
        device_add_attrs
          device_add_groups
            sysfs_create_groups(pmu::attr_groups)

This interface does not provide a way to have multiple attribute
groups, which could add files into same directory, all has to be
prepared ahead.

This patchset adds 'update attribute group', which is added via new
sysfs_update_groups function, after the initial set of attributes
is created. The group's is_visible function will cover its HW
dependency/visibility.

This will allow us to update "events" or "format" directories with
attributes that depend on various HW config.

For example having group_format_extra group, that updates "format"
directory, only if pmu version is 2 and higher:

  static umode_t
  lbr_is_visible(struct kobject *kobj, struct attribute *attr, int i)
  {
         return x86_pmu.lbr_nr ? attr->mode : 0;
  }

  static struct attribute_group group_caps_lbr = {
         .name       = "caps",
         .attrs      = lbr_attrs,
         .is_visible = lbr_is_visible,
  };

Note that some of the groups are defined without 'attrs' set,
which is assigned later based on the detected cpu model.

And finally we'll end up with just a single set of attribute groups:

  static const struct attribute_group *attr_update[] = {
          &group_events_td,
          &group_events_mem,
          &group_events_tsx,
          &group_caps_gen,
          &group_caps_lbr,
          &group_format_extra,
          &group_format_extra_skl,
          &group_default,
          NULL,
  };

that is passed to struct pmu.

Also available in:
  git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  perf/x86_attrs

thoughts? thanks,
jirka


[1] https://lore.kernel.org/lkml/20190318182116.17388-1-jolsa@kernel.org/
---
Jiri Olsa (8):
      sysfs: Add sysfs_update_groups function
      perf: Add attr_groups_update into struct pmu
      perf/x86: Get rid of x86_pmu::event_attrs
      perf/x86: Use the new pmu::update_attrs attribute group
      perf/x86: Add is_visible attribute_group callback for base events
      perf/x86: Use update attribute groups for caps
      perf/x86/intel: Use update attributes for skylake format
      perf/x86: Use update attribute groups for default attributes

 arch/x86/events/core.c       | 105 +++++++++++++++------------------------------------------------------------------------------------------
 arch/x86/events/intel/core.c | 144 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------------------------------------------
 arch/x86/events/perf_event.h |   7 +------
 fs/sysfs/group.c             |  43 ++++++++++++++++++++++++++++---------------
 include/linux/perf_event.h   |   1 +
 include/linux/sysfs.h        |   2 ++
 kernel/events/core.c         |   6 ++++++
 7 files changed, 145 insertions(+), 163 deletions(-)
