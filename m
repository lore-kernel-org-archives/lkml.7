Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E423EC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B223020651
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfHSOcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 10:32:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41198 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbfHSOcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 10:32:23 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4804A300413D;
        Mon, 19 Aug 2019 14:32:23 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C58AB1C930;
        Mon, 19 Aug 2019 14:32:22 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] libnvdimm/security: Tighten scope of nvdimm->busy vs security operations
References: <156583201347.2815870.4687949334637966672.stgit@dwillia2-desk3.amr.corp.intel.com>
        <156583202386.2815870.16611751329252858110.stgit@dwillia2-desk3.amr.corp.intel.com>
        <x49zhk8bzuh.fsf@segfault.boston.devel.redhat.com>
        <CAPcyv4iPBO9atdr_LdHNt=tCgjh-j_HyKXaCdUkWxb_J7OCcxg@mail.gmail.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Mon, 19 Aug 2019 10:32:22 -0400
In-Reply-To: <CAPcyv4iPBO9atdr_LdHNt=tCgjh-j_HyKXaCdUkWxb_J7OCcxg@mail.gmail.com>
        (Dan Williams's message of "Fri, 16 Aug 2019 14:02:19 -0700")
Message-ID: <x49d0h1usy1.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Mon, 19 Aug 2019 14:32:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Williams <dan.j.williams@intel.com> writes:

> On Fri, Aug 16, 2019 at 1:49 PM Jeff Moyer <jmoyer@redhat.com> wrote:
>>
>> Dan Williams <dan.j.williams@intel.com> writes:
>>
>> > The blanket blocking of all security operations while the DIMM is in
>> > active use in a region is too restrictive. The only security operations
>> > that need to be aware of the ->busy state are those that mutate the
>> > state of data, i.e. erase and overwrite.
>> >
>> > Refactor the ->busy checks to be applied at the entry common entry point
>> > in __security_store() rather than each of the helper routines.
>>
>> I'm not sure this buys you much.  Did you test this on actual hardware
>> to make sure your assumptions are correct?  I guess the worst case is we
>> get an "invalid security state" error back from the firmware....
>>
>> Still, what's the motivation for this?
>
> The motivation was when I went to test setting the frozen state and
> found that it complained about the DIMM being active. There's nothing
> wrong with freezing security while the DIMM is mapped. ...but then I
> somehow managed to write this generalized commit message that left out
> the explicit failure I was worried about. Yes, moved too fast, but the
> motivation is "allow freeze while active" and centralize the ->busy
> check so it's just one function to review that common constraint.

OK, thanks for the info.

Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
