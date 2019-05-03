Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01AAC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 17:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9239E20675
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 17:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556905502;
	bh=egFQTKMYZPhfVPNwf7JHu5iByyXuwNSifAVN0WcPun4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Im9bi9qt7VvPFqHzIMnX5+dk9rmY3ueKMyrZsEgCKiz2fwVeI1kZi9c1c2iaaOYBe
	 NtudqBA+aBNexfeBmntpQVZaUckDrNr2o49CRLpQz7u36kEMh+RRLAlYRVLRxnrwFS
	 nxHLNJKW/p3RFIrZUOKISWcf4UC860ieIrejUsyU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbfECRpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 13:45:01 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39678 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfECRpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 13:45:00 -0400
Received: by mail-wm1-f68.google.com with SMTP id n25so7625043wmk.4;
        Fri, 03 May 2019 10:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t4cyN7e/E+3KAl7sbPpgTsGbsxg6GONbg48fXIFY76o=;
        b=smqsaY2ywLCfyclbZ+5qDfOP6UVYS+/rtIHjag/XRu1E8e74lgG0xBKlB096D9p/Sv
         yYSwo94H8qW7fQDzJbvf7/AfQav5mSud7Cu+RuwDj7MCQsOn+8VYRyqu6y6xcRWQb+hH
         94Nq1ElyUz5A1Pelm17w67FVkBt5tx44IgGVg3Q6T37ZvZa+AUdDIenKtO3q6RW185OE
         E1/zhca+fgFqb/rEpj92xPrzDaWUhq1yXG1z/DASdgtKP4k69zEc2rutle7CqRwAs/4A
         5mzknstcA3GK0Qf2rLBxASNsiVdcAOiLBE21Dp8ofXD6hJAO/lkLcqx1jMlFrAdyB7sc
         uOvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=t4cyN7e/E+3KAl7sbPpgTsGbsxg6GONbg48fXIFY76o=;
        b=n81WzB5pnKWfjG+kvNc4duTzdkWEVxP9QepBnLqIWg1qrSoE30UDL8ccOOxqnJeVxW
         0otqxCEweai0WTn+m5WFDw7/B294CC1YHiIaXKkIg7G+QebVdry9EBxhix0Zlt80C+qL
         JRH7VhsT5kzV7bs3ycYG6pSwH2gJKX4ns9BwkX8af54zuulDL0ifpDmRbLi8GtqLFZHk
         S82sK10RGCxdEqWq8y2yxIsQBsjDR+yLzwt0V2tUj89hGhNdFyCRaLG4gmeJQD21hQJj
         0X+fuQY41OqigyLNcuDeUJYlGLVqU3fG6pBa+Lry4c5nAhybqIWEMQp8loCmHTzqzadl
         Us/A==
X-Gm-Message-State: APjAAAUL4DwZfiPQZE/iWDHBu/LV82vFufOCD+EDxD1Bwa1qxADpT8F6
        Vh7TaGQ5aZm2DDZw6GIVNao=
X-Google-Smtp-Source: APXvYqzBWf8fKDF6Kp9Ud0HFoTG2rxkjduJGSvdXpNA83cq6Nuv2dkbLXqYgqTlo46CAGzYmfb+xJw==
X-Received: by 2002:a1c:eb12:: with SMTP id j18mr7692987wmh.48.1556905498724;
        Fri, 03 May 2019 10:44:58 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id c204sm16769255wmd.0.2019.05.03.10.44.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 May 2019 10:44:58 -0700 (PDT)
Date:   Fri, 3 May 2019 19:44:55 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Changbin Du <changbin.du@gmail.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/27] Include linux x86 docs into Sphinx TOC tree
Message-ID: <20190503174455.GA69353@gmail.com>
References: <20190502070633.9809-1-changbin.du@gmail.com>
 <20190503064347.1d027e87@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190503064347.1d027e87@lwn.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Jonathan Corbet <corbet@lwn.net> wrote:

> On Thu,  2 May 2019 15:06:06 +0800
> Changbin Du <changbin.du@gmail.com> wrote:
> 
> > The kernel now uses Sphinx to generate intelligent and beautiful documentation
> > from reStructuredText files. I converted all of the Linux x86 docs to rst
> > format in this serias.
> > 
> > For you to preview, please visit below url:
> > http://www.bytemem.com:8080/kernel-doc/index.html
> 
> x86 folks: how would you like to handle this set?  Take it yourselves,
> have me take it, print it out and set it on fire, ...?

If you are otherwise happy with it:

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
