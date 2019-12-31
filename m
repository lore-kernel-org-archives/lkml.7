Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FAB7C2D0DC
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 19:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3346206DA
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 19:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bJjpSNTJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfLaT7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 14:59:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59008 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727075AbfLaT7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 14:59:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577822338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=UfFFcmxyB90xrFgf0Ywd7HDmQ8GU/gCbJIPy3bsCSMo=;
        b=bJjpSNTJdIby40l7YM6e3SqwlpnSVg0paXBQjKfe8W0NBpgdHRKsbaN+h0Kifc2ShvcJZC
        9jjGYlU7Fdge0p6mTGhpeRERIml04aJGfS6s2C5oIHmB4E4Mh1QFxXEZp9/565Qerm60HA
        LTYUxkFE2M8IevJE1+8fPouPN5xVbJg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-c3RYn1UbNj-F_nnmtnhpiQ-1; Tue, 31 Dec 2019 14:58:56 -0500
X-MC-Unique: c3RYn1UbNj-F_nnmtnhpiQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 453D4800EBF;
        Tue, 31 Dec 2019 19:58:55 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-15.phx2.redhat.com [10.3.112.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0ED3660BEC;
        Tue, 31 Dec 2019 19:58:47 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     containers@lists.linux-foundation.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     eparis@parisplace.org, Steve Grubb <sgrubb@redhat.com>,
        omosnace@redhat.com, Paul Moore <paul@paul-moore.com>,
        nhorman@redhat.com, dwalsh@redhat.com, mpatel@redhat.com,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghau51/ghau40 v8 00/14] add support for audit container identifier
Date:   Tue, 31 Dec 2019 14:58:07 -0500
Message-Id: <1577822301-19760-1-git-send-email-rgb@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for audit kernel container identifiers to userspace tools.

The first and second add new record types.  The third adds filter
support.  The fourth and 5th start to add search support.

The 6th is to read the calling process' audit container identifier from
the /proc filesystem matching the kernel /proc read patch.

The 7th is to fix signal support and the 8th is to learn the audit
container identifier of the process that signals the audit daemon.

The 9th is a touch up to allow the contid field to be interpreted as a
CSV list.

The 10th and 11th add audit contid list support to ausearch.

The 12th and 13th add support to auditctl for setting the limits for nesting
depth and netns contid counts to prevent overflowing the contid text
fields in CONTAINER_* records.

The last adds audit library support to allow a process to give
permission to a container orchestrator in a non-init user namespace via
audit netlink messages.

See: https://github.com/linux-audit/audit-userspace/issues/51
See: https://github.com/linux-audit/audit-userspace/issues/40
See: https://github.com/linux-audit/audit-kernel/issues/90
See: https://github.com/linux-audit/audit-kernel/issues/91
See: https://github.com/linux-audit/audit-testsuite/issues/64
  https://githu.com/linux-audit/audit-testsuite/pull/91
  https://github.com/rgbriggs/audit-testsuite/tree/ghat64-contid
See: https://github.com/linux-audit/audit-kernel/wiki/RFE-Audit-Container-ID

A repo of the code is here:
  git@github.com:rgbriggs/audit-userspace.git ghau40-containerid-filter.v8
And test rpms built from it are here:
  people.redhat.com/~rbriggs/ghak90/git-47ad4ca

Changelog:
v8
- renumber contid records and drop netlink contid set/get support
- remove subject attributes from parse_container_op()
- fix audit_request_signal_info.3 manpage
- add manpage for audit_set_capcontid()
- implement clist for contid list search
- rebase on audit_bpf patches (bump CONTAINER_ID to 1335)
- implement control for audit container identifier nesting depth limit with manpage
- implent control for audit container identifier netns count limit with manpage

v7
- rebase on ghau90 and touchup
- rebase on ghak10 support (change AUDIT_CONTAINER_ID to 1334)
- render type contid as a CSV
- switch from /proc to audit netlink to set/get contid, auid/sessionid
- add support for capcontid

v6
- auditd signaller tracking was moved to a new AUDIT_SIGNAL_INFO2
  request and record
- swap CONTAINER_OP contid/old-contid to ease parsing
- add to auparse

v5
- updated aux record from AUDIT_CONTAINER to AUDIT_CONTAINER_ID
- add AUDIT_CONTAINER_ID to normalization
- rebase on AUDIT_ANOM_LINK and AUDIT_MAC_CALIPSO_ADD

v4
- change from AUDIT_CONTAINER_ID to AUDIT_CONTAINER_OP
- change from AUDIT_FEATURE_BITMAP_CONTAINERID_FILTER to
  AUDIT_FEATURE_BITMAP_CONTAINERID
- change from event_container_id to event_contid internally
- change from container_id to contid and event_container_id to
  event_contid internally
- change command line option from --container-id to --contid

v3
- change from AUDIT_CONTAINER to AUDIT_CONTAINER_ID
- change from AUDIT_CONTAINER_INFO to AUDIT_CONTAINER
- change from AUDIT_CONTAINERID to AUDIT_CONTID
- update github issue refs
- add audit_get_containerid
- change event_container_id default value
- add --containerid to ausearch options help text
- update ausearch parser and error codes

v2
- rebase on UINT_MAX patch
- add patches for AUDIT_CONTAINER, AUDIT_CONTAINER_INFO, ausearch,
  normalization

Richard Guy Briggs (14):
  AUDIT_CONTAINER_OP message type basic support
  AUDIT_CONTAINER_ID message type basic support
  auditctl: add support for AUDIT_CONTID filter
  add ausearch containerid support
  start normalization containerid support
  libaudit: add support to get the task audit container identifier
  signal_info: only print context if it is available.
  add support for audit_signal_info2
  contid: interpret correctly CONTAINER_ID contid field csv
  ausearch: convert contid to comma/carrat-sep list
  ausearch: convert contid to comma/carrat-sep cnode/clist
  auditctl: add a config parameter to limit the contid nesting depth
  auditctl: add a config parameter to limit the contid netns count
  libaudit: add support to get and set capcontid on a task

 auparse/auditd-config.c             |   1 +
 auparse/auparse-defs.h              |   3 +-
 auparse/interpret.c                 |  10 ++
 auparse/normalize_record_map.h      |   2 +
 auparse/typetab.h                   |   2 +
 bindings/python/auparse_python.c    |   1 +
 configure.ac                        |   2 +
 docs/Makefile.am                    |   6 +-
 docs/audit_get_capcontid.3          |  25 ++++
 docs/audit_get_containerid.3        |  25 ++++
 docs/audit_request_signal_info.3    |  11 ++
 docs/audit_set_capcontid.3          |  24 ++++
 docs/audit_set_contid_depth_limit.3 |  26 ++++
 docs/audit_set_contid_netns_limit.3 |  25 ++++
 docs/auditctl.8                     |   9 ++
 lib/fieldtab.h                      |   1 +
 lib/libaudit.c                      | 230 ++++++++++++++++++++++++++++++++++--
 lib/libaudit.h                      |  36 ++++++
 lib/msg_typetab.h                   |   4 +
 lib/netlink.c                       |   5 +
 src/Makefile.am                     |   6 +-
 src/auditctl-listing.c              |  29 +++++
 src/auditctl.c                      |  66 +++++++++++
 src/auditd-config.c                 |   1 +
 src/auditd-config.h                 |   1 +
 src/auditd-event.c                  |  28 ++++-
 src/auditd-reconfig.c               |  25 ++--
 src/auditd.c                        |   3 +-
 src/aureport-options.c              |   1 +
 src/ausearch-contid.c               | 171 +++++++++++++++++++++++++++
 src/ausearch-contid.h               |  61 ++++++++++
 src/ausearch-llist.c                |   6 +
 src/ausearch-llist.h                |   2 +
 src/ausearch-match.c                |  35 ++++++
 src/ausearch-options.c              |  77 +++++++++++-
 src/ausearch-options.h              |   2 +
 src/ausearch-parse.c                | 131 ++++++++++++++++++++
 src/ausearch-report.c               |   6 +-
 38 files changed, 1068 insertions(+), 31 deletions(-)
 create mode 100644 docs/audit_get_capcontid.3
 create mode 100644 docs/audit_get_containerid.3
 create mode 100644 docs/audit_set_capcontid.3
 create mode 100644 docs/audit_set_contid_depth_limit.3
 create mode 100644 docs/audit_set_contid_netns_limit.3
 create mode 100644 src/ausearch-contid.c
 create mode 100644 src/ausearch-contid.h

-- 
1.8.3.1

