Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3609C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 21:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB8B12075B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 21:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559682496;
	bh=BHnbZCrtJN3J4CIZxdXcdY8wC2tqsv+UK40yvVYt5IU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=lvjHM7Jbps41MokMooLAmnU9HEd/ygNLRnz4qzxey1e9e3nZi7CblnjQCxp3MUVN5
	 Jz5s3/LtR/dsSUaILxDFRuLr2Q3ajOjub2lfFsX6fueBfm2MI77LBHvMfeoRjOC5tx
	 HRDJYAqnR+yB27m8iay3jQPCME6Zxut19w4y80/g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfFDVIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 17:08:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:50436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbfFDVIP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 17:08:15 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7A282070B;
        Tue,  4 Jun 2019 21:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559682494;
        bh=BHnbZCrtJN3J4CIZxdXcdY8wC2tqsv+UK40yvVYt5IU=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=UxyLIH3GnOwWrkcv9+8PawOQ2V4Pa13WmgfvfIuoTWm11IGnhetHluLq1dYjTl3hE
         37/6jpkFLZWVM2bFGa9JQyUS87V6gJskq8eOPscArvax2sJZCGHS6H1Dmtee3JPih7
         Yg++JMuTpH5AK5oIEV572YZeiUFHPCb3GBbNU2yk=
Date:   Tue, 4 Jun 2019 23:08:11 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
cc:     Hans de Goede <hdegoede@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: hid-related 5.2-rc1 boot hang
In-Reply-To: <CAO-hwJJWWRf8cCLCB3JdfFGCGPnp9ar9HC_QAg7crJ0y+pA-hg@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.1906042307260.27227@cbobk.fhfr.pm>
References: <2c1684f6-9def-93dc-54ab-888142fd5e71@intel.com> <nycvar.YFH.7.76.1905281913140.1962@cbobk.fhfr.pm> <CAO-hwJJzNAuFbdMVFZ4+h7J=bh6QHr_MioyK2yTV=M5R6CTm=A@mail.gmail.com> <8a17e6e2-b468-28fd-5b40-0c258ca7efa9@intel.com> <4689a737-6c40-b4ae-cc38-5df60318adce@redhat.com>
 <a349dfac-be58-93bd-e44c-080ed935ab06@intel.com> <nycvar.YFH.7.76.1906010014150.1962@cbobk.fhfr.pm> <e158d983-1e7e-4c49-aaab-ff2092d36438@redhat.com> <5471f010-cb42-c548-37e2-2b9c9eba1184@redhat.com> <CAO-hwJKRRpsShw6B-YLmsEnjQ+iYtz+VmZK+VSRcDmiBwnS+oA@mail.gmail.com>
 <e431dafc-0fb4-4be3-ac29-dcf125929090@redhat.com> <CAO-hwJ+5UYJMnuCS0UL4g45Xc181LraAzc-CMuYB2rcqKGe_Sw@mail.gmail.com> <4548d196-b75f-c4d0-8f3c-3e734b9a758c@redhat.com> <c05929f4-00b6-e098-cd69-cd6539ccd3f1@redhat.com>
 <CAO-hwJJWWRf8cCLCB3JdfFGCGPnp9ar9HC_QAg7crJ0y+pA-hg@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jun 2019, Benjamin Tissoires wrote:

> > Which should fix this. It is quite simple and safe, so if we get testing
> > feedback relatively soon, we could go with the fix instead of dropping the
> > product-id, your call.
> 
> I should receive the M280 tomorrow, hopefully with the C52F. If the
> receiver is correct and the tests are successful, I'd prefer to take
> this one over the revert :)

Agreed at this release phase. And if it doesn't work, immediate revert for 
now and proper fix for 5.3-rc1.

Thanks,

-- 
Jiri Kosina
SUSE Labs

