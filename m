Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FA9C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 12:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18A872075E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 12:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tGUQUW65"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731692AbfFSMDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 08:03:20 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46473 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfFSMDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 08:03:20 -0400
Received: by mail-qk1-f196.google.com with SMTP id x18so10662624qkn.13;
        Wed, 19 Jun 2019 05:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UUNDJ4YT5sYe2FSF11R8Qj2KGP81ymPOsgrPA4bzlUM=;
        b=tGUQUW65p6WjgVCM2/lZ12D8gBKslhHKRm5kkwDJN4DXSuK4hLzZAwUvjukLfRQeGE
         yMWqA79F5yIo11HDizUNdV3vX4zxcPy/yz/7Y2c/BdCQAP0pAD/pT01zIbpTIrMVhG6a
         pWWoBrCXg2Gr8HV/xcIUifnm4emFfzDrG9VADVfGzhrNybHtTeJwJf91XNHHTmD77O2G
         34E19ceLrLkYYaUqMoc8M9w5F9/n+Dbf6kBnIHyr6Ezkj+wZDHR7SAci+GGI2rr+EC4y
         CPOGu5tv2LpKzVGl3rdCp7uqtyHjgIEvp/YctuzPs5QUhGZ2MS6K4+VUueNs1SVHRK/a
         H71g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UUNDJ4YT5sYe2FSF11R8Qj2KGP81ymPOsgrPA4bzlUM=;
        b=kwXkKndAa4S6Lq/k4ZpXe5Xm39uYpOCNy30d39fhuixXOVkkzF2PgbqSH5VMPnQ5HL
         HLsMWHSO0l67DwFp482TJOYZE7M7C5yH77J7Ba0bMCmmgxFZla0TNqnrMLIy3nHeJmKH
         5/ugnRReJ0EwCMeLqwydaUbaKLg71rFjbOLKdBnrU5YLN9u7ltqdxX6C+7u55qfx016b
         zA0IMQ65AG8aMtHUPprkKC0CBCRde5XQ0F0dFoHTx8sal73wIi0K+vZVsnTsFShg1DEY
         5OYT2hjuI4xBwyVCxWzmM+Nj5ZyrCK4QdytavSUp4g8bq/N9bfnZqlfdMTmFncpXnBn4
         zJmw==
X-Gm-Message-State: APjAAAWVE5w99SEORduMKVlj/B1WbifmhGbHVN4Oo6I8dDN4zkPagHY4
        MKEC6+eGzRbPDs53LdH02iM=
X-Google-Smtp-Source: APXvYqxBoaY0rL+zlXSIQpf+ih0yitbR1m/XjjH1n/Rjg85Fccc83qRq07beePWyBu5iXiE7CJBNRA==
X-Received: by 2002:a37:696:: with SMTP id 144mr95924137qkg.250.1560945799007;
        Wed, 19 Jun 2019 05:03:19 -0700 (PDT)
Received: from continental ([186.212.50.252])
        by smtp.gmail.com with ESMTPSA id s134sm10974868qke.51.2019.06.19.05.03.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 05:03:18 -0700 (PDT)
Date:   Wed, 19 Jun 2019 09:03:52 -0300
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: Re: [PATCH 1/2] scsi: devinfo: BLIST_TRY_VPD_PAGES for SanDisk
 Cruzer Blade
Message-ID: <20190619120346.GC26980@continental>
References: <20190618013146.21961-1-marcos.souza.org@gmail.com>
 <20190618013146.21961-2-marcos.souza.org@gmail.com>
 <yq1r27quuod.fsf@oracle.com>
 <20190619094540.GA26980@continental>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619094540.GA26980@continental>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 06:45:43AM -0300, Marcos Paulo de Souza wrote:
> On Tue, Jun 18, 2019 at 11:21:22PM -0400, Martin K. Petersen wrote:
> > 
> > Marcos,
> > 
> > > Currently, all USB devices skip VPD pages, even when the device
> > > supports them (SPC-3 and later), but some of them support VPD, like
> > > Cruzer Blade.
> > 
> > What's your confidence level wrt. all Cruzer Blades handling this
> > correctly? How many devices have you tested this change with?
> 
> I've tested three Cruzer Blades that I have at hand, and all  of them have VPD
> support, and also checked with a friend of mine that also have one. I can't say
> about "all others" but so far, 4/4 devices that I tested have VPD. (They were all
> SPC-3 or SPC-4 compliant).
> 

My first idea was to add a vendor:product mapping at SCSI layer, but so far I
haven't found one, so I added the model/vendor found by INQUIRY. Would it be
better to check for prod:vendor (as values, instead of the description)?

Thanks,
Marcos


> > 
> > -- 
> > Martin K. Petersen	Oracle Linux Engineering
