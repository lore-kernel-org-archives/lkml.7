Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8783C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 09:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1A4B2084A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 09:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSQsPBde"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731529AbfFSJpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 05:45:17 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46062 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbfFSJpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 05:45:16 -0400
Received: by mail-qt1-f196.google.com with SMTP id j19so19027637qtr.12;
        Wed, 19 Jun 2019 02:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6yzdUzmo404LE41DAFTy9JSL/AHqS+IofJkeqyqlqXM=;
        b=YSQsPBdeVFqPO4k13m19F3LD8n08NG8MIn8ioPb1XG58y0cb9sh9s2inNUBQZ2ViiW
         An/UM8unZjM82w8J4wrfPZPqVnewNa4/p2kqYw4lmUwb8t2Ib7GzvWX8+9+/fUynGDHS
         aC58zCRNqpWGrVgy/NHjasLEfX/AOTqda4pdvgAaoQ8lbR3Vid4PEdOl5XUtGeusLODS
         avj2sCcioN0Wu9HJH+cIbWogVYUqSqVt4KoJ67zJDnoMqYh6m+B3vt5Y2tcSL+XSsmzk
         1haaRyFLLB7R1mo2H8v1rlQgauVDYGIz/GoYDwaFeCPNPuV8OdIK/Bz/lTXznSw6pJjt
         9pgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6yzdUzmo404LE41DAFTy9JSL/AHqS+IofJkeqyqlqXM=;
        b=lWJM60FVDLDJ10zJS1sCtSb5EECE2/TgliNXkcdtcVqMcpUCGlq69KYE+jBr6ZORv+
         XoV8xHWzbWMNWGHD/ikK4cOqJJg2ti/DjgqzkfvcwSXYJmH4SHPZ9NO5KECF+4NseY8q
         c0ePKS95V04xWaLPheSj5seqG4uoKkyVx7SwRL3+JTvg5Rya3NLcmuxO7GQlM/oBxFgX
         OhNj2vpPwZinRkxGCr4kAbE/lTErnYD3PKUK8XSDlOZWRUET4Xrkmqwc+WPyLpYCyWXp
         cEiSjQo3HPggGVIIjoe57co6STDgGi7eN8YQgSmsWck8qKtmn7d5GYnhQRIcGHXt9oMK
         DRHg==
X-Gm-Message-State: APjAAAUYHhGJe+CvxLODT8fv+aYOt4TKg6GtlV9cUVXg6Jrpv01Ee4HF
        KDw0Am8i5aUpudZ4AnIGq+pqdfs6Lls=
X-Google-Smtp-Source: APXvYqwkgLAF0LrMgAIKw/7vQrmKnZS+4+KL47Na2ywBqsjuimj4HEiHz7IiwfCRl6Qfje+SSMtOww==
X-Received: by 2002:aed:33e6:: with SMTP id v93mr105873713qtd.157.1560937515388;
        Wed, 19 Jun 2019 02:45:15 -0700 (PDT)
Received: from continental ([186.212.50.252])
        by smtp.gmail.com with ESMTPSA id t197sm9802121qke.2.2019.06.19.02.45.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 02:45:14 -0700 (PDT)
Date:   Wed, 19 Jun 2019 06:45:43 -0300
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: Re: [PATCH 1/2] scsi: devinfo: BLIST_TRY_VPD_PAGES for SanDisk
 Cruzer Blade
Message-ID: <20190619094540.GA26980@continental>
References: <20190618013146.21961-1-marcos.souza.org@gmail.com>
 <20190618013146.21961-2-marcos.souza.org@gmail.com>
 <yq1r27quuod.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1r27quuod.fsf@oracle.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 11:21:22PM -0400, Martin K. Petersen wrote:
> 
> Marcos,
> 
> > Currently, all USB devices skip VPD pages, even when the device
> > supports them (SPC-3 and later), but some of them support VPD, like
> > Cruzer Blade.
> 
> What's your confidence level wrt. all Cruzer Blades handling this
> correctly? How many devices have you tested this change with?

I've tested three Cruzer Blades that I have at hand, and all  of them have VPD
support, and also checked with a friend of mine that also have one. I can't say
about "all others" but so far, 4/4 devices that I tested have VPD. (They were all
SPC-3 or SPC-4 compliant).

> 
> -- 
> Martin K. Petersen	Oracle Linux Engineering
