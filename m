Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4AFC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 11:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACAD0217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 11:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555586847;
	bh=AFODF35XLTunm17wYNPVwcvIsnJRKvCIHaBaEHGenH4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=k5nZxr+DwBTBscBWD9GWcmPs1XaYfcg+ImzcRDChcIP5VfuB2OEGDjR1Lzk28gFZJ
	 BPl7XrPz859MTuuGormRMiRkH4DfbyjMYc9Qq7w0vvdShKX/nUFvI9GwHc+5OolM86
	 lhO9Yc4nMgUT5FzOrXVkqYYlBi1M/64VqGvrM9Mw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388855AbfDRL10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 07:27:26 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42642 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbfDRL1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 07:27:25 -0400
Received: by mail-wr1-f65.google.com with SMTP id g3so2519524wrx.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 04:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=bLaZuN/hRD0d+pJMgtaDzlUUhSLQrIkz2oyr6G1O+2M=;
        b=e9xqQ90o76OMAqTd6b70t9wd7GkxJezDmLYCZ08jiat+LFLF3SYPJlpk2yctrl1GcQ
         8EBC6kg5dhsUjRz6yn9lA05D9U1Xr2C1Kx8VPBgnnYErGRf0O4IUL0ARrNWRhkMAkr9d
         aawiIp5fiTufdjLVX/gr/iqAIiSmjdBHoREH6A5ddsnnjB/4bekpAwsrHDt+u7ChmaUC
         rbDWvyGGwviPjDpSqO/knvkr/mgFe59X/huqA6DqaZp2+xLqIIOilWb3TRUIMScWUi1u
         Px7j7Q64iKPNL6GmsaYRin3+ainvJWtehYvojyhrhlgCgfE+j82uUIqGUzVy4ZVHW2sc
         5Bcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=bLaZuN/hRD0d+pJMgtaDzlUUhSLQrIkz2oyr6G1O+2M=;
        b=CrWvN8o9l4CfywJkJag45g9gx0RcENnG+13mvpMHdNScWPHK5Ik2LFvTAuqKR8S/gs
         /XuchsQh2N4/0AWtVzHxgnjmfRBLqeJTMeL71QpdtWxp4ljmI2YWHX5cNNKD68SuoNst
         aUPAdzF3HZ7A5l5rUKFxK6nKQ1xFI2rnjD0ghyjfhSa+gMO0sLJ4SV7Go+WBVMmxaoxh
         QrdbMH0wfBJLpONU2r3NtBvIDnWvt2jGKD6E/AvfGikeyzBFO/Pj9bvR9I5oL0W1JjLE
         GFj0sp+KQ800sD+RdygqtIydKyuG2lZtmYRNYIVWi4Qq+a8lm2cRrB3m+XuY9ca4QnMv
         EXJg==
X-Gm-Message-State: APjAAAWmFH1OmHX683YVqlyh2AnqM2Ozd1wOV1FEUhwpXm5Tsw5/YHQg
        V2fTN3qN1h/Ucuomm+vESmo=
X-Google-Smtp-Source: APXvYqyU1+eboXOTgKbosqKNm4QMb/Pwe/E018gMfxdJLX6OYgf6GKHIwyfJ9/dXP/olPwaLn7NpjQ==
X-Received: by 2002:a5d:5190:: with SMTP id k16mr1062914wrv.10.1555586844340;
        Thu, 18 Apr 2019 04:27:24 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id l19sm2574158wrf.35.2019.04.18.04.27.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Apr 2019 04:27:23 -0700 (PDT)
Date:   Thu, 18 Apr 2019 13:27:21 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/boot: This program cannot be run in DOS mode.$
Message-ID: <20190418112721.GA9248@gmail.com>
References: <20190401102434.9805-1-pali.rohar@gmail.com>
 <20190408180422.GA5103@amd>
 <20190408180809.myjp5zaviuibj5uf@pali>
 <20190408212506.GA6428@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190408212506.GA6428@amd>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Pavel Machek <pavel@ucw.cz> wrote:

> On Mon 2019-04-08 20:08:09, Pali Rohár wrote:
> > On Monday 08 April 2019 20:04:22 Pavel Machek wrote:
> > > On Mon 2019-04-01 12:24:34, Pali Rohár wrote:
> > > > Every EFI binary is in PE format. And we know that PE format needs to have
> > > > MZ MS-DOS header as there is written offset to PE header.
> > > > 
> > > > Therefore generated bzImage binary with CONFIG_EFI_STUB option is MS-DOS
> > > > executable binary.
> > > > 
> > > > We already know the "requirement" that Windows PE executable started in
> > > > MS-DOS must print legendary and famous message to computer screen:
> > > > "This program cannot be run in DOS mode."
> > > > 
> > > > But trying to run that bzImage of Linux kernel with MZ header just cause
> > > > freezing whole MS-DOS instead of writing "the correct message" to user.
> > > > This is not the compliant behavior of PE executables!
> > > > 
> > > > This patch fixes this problem. When Linux kernel compiled with
> > > > CONFIG_EFI_STUB is started in MS-DOS then it prints message:
> > > > 
> > > >   This program cannot be run in DOS mode.
> > > >   To load Linux kernel from DOS mode use LOADLIN.EXE.
> > > > 
> > > > So it also helps MS-DOS users how to "correctly" start this bzImage binary
> > > > by mentioning LOADLIN.EXE. Note that MS-DOS strings are not null-terminated
> > > > but rather dollar-terminated.
> > > > 
> > > > To have error message unified bugger_off_msg for BIOS boot block code was
> > > > changed to:
> > > > 
> > > >   This program cannot be run in BIOS mode.
> > > > 
> > > > So if you copy generated bzImage directly to boot sector and try to boot it
> > > > by BIOS you get this new updated message.
> > > > 
> > > > Due to fixed offset of setup header (0x1f1), PE header was moved after
> > > > entrytext section. bstext and bsdata sections where is full MZ header and
> > > > MS-DOS code is now bigger.
> > > 
> > > Hehe, I guess the patch may have been dropped due to april's fools?
> > 
> > Yea, it was mean as first April patch :-) I tested it with MS-DOS 7.0
> > and DOSBox and it worked.
> > 
> > > You may want to retransmit?
> > 
> > Do you really think it can be useful? :-)
> 
> Dunno. It is quite simple, and quite a nice hack ;-).

Agreed, looks simple enough, no objections from me! :)

	Ingo

