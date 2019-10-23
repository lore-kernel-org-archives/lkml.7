Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943A6CA9EA0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 02:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F898214B2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 02:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389016AbfJWCgu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 22:36:50 -0400
Received: from tyo161.gate.nec.co.jp ([114.179.232.161]:49935 "EHLO
        tyo161.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730655AbfJWCgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 22:36:49 -0400
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo161.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x9N2aRKv011049
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 23 Oct 2019 11:36:27 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x9N2aRfM032034;
        Wed, 23 Oct 2019 11:36:27 +0900
Received: from mail03.kamome.nec.co.jp (mail03.kamome.nec.co.jp [10.25.43.7])
        by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x9N2XWcx006253;
        Wed, 23 Oct 2019 11:36:27 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.147] [10.38.151.147]) by mail01b.kamome.nec.co.jp with ESMTP id BT-MMP-9712104; Wed, 23 Oct 2019 11:15:10 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC19GP.gisp.nec.co.jp ([10.38.151.147]) with mapi id 14.03.0439.000; Wed,
 23 Oct 2019 11:15:09 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     Oscar Salvador <osalvador@suse.de>
CC:     Michal Hocko <mhocko@kernel.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 10/16] mm,hwpoison: Rework soft offline for free
 pages
Thread-Topic: [RFC PATCH v2 10/16] mm,hwpoison: Rework soft offline for free
 pages
Thread-Index: AQHVhPYxuKrdanK4Pk2pyFsBlimO86dfuBWAgATFroCAAC2WAIABDXAAgAALI4CAAAKLgIAADVAAgAAKCgCAAAdKgIAAAl2AgAEHHQA=
Date:   Wed, 23 Oct 2019 02:15:08 +0000
Message-ID: <20191023021508.GA29387@hori.linux.bs1.fc.nec.co.jp>
References: <20191018120615.GM5017@dhcp22.suse.cz>
 <20191021125842.GA11330@linux> <20191021154158.GV9379@dhcp22.suse.cz>
 <20191022074615.GA19060@linux> <20191022082611.GD9379@dhcp22.suse.cz>
 <20191022083505.GA19708@linux> <20191022092256.GH9379@dhcp22.suse.cz>
 <20191022095852.GB20429@linux> <20191022102457.GJ9379@dhcp22.suse.cz>
 <20191022103319.GA21736@linux>
In-Reply-To: <20191022103319.GA21736@linux>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.96]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <E800C125A5CD5A43AD8AFB60C05422A0@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 12:33:25PM +0200, Oscar Salvador wrote:
> On Tue, Oct 22, 2019 at 12:24:57PM +0200, Michal Hocko wrote:
> > Yes, that makes a perfect sense. What I am saying that the migration
> > (aka trying to recover) is the main and only difference. The soft
> > offline should poison page tables when not able to migrate as well
> > IIUC.
> 
> Yeah, I see your point.
> I do not really why soft-offline strived so much to left the page
> untouched unless it was able to content the problem.
> 
> Note that if we start now to poison pages even if we could not 
> content them (in soft-offline mode), that is a big and visible user
> change.

It's declared that soft offline never disrupts userspace by design,
so if poisoning page tables in migration failure, we could break this
and send SIGBUSs.  Then end users would complain that their processes
are killed by corrected (so non-urgent) errors.

Thanks,
Naoya Horiguchi
