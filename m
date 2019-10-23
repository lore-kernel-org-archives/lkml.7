Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E490CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 11:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32BA42064A
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 11:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LuEjJ4Kr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404829AbfJWL1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 07:27:21 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55078 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732149AbfJWL1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 07:27:21 -0400
Received: by mail-wm1-f67.google.com with SMTP id g7so2738449wmk.4;
        Wed, 23 Oct 2019 04:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fb1aYcSbpq+9iaeIeVo4QA9jJ6hhJT83G2zP5+xozbs=;
        b=LuEjJ4KrhoHTIiiGH1NOFoCM9U0V8AryNd/hjKDnuqr9sxyP4/5VcFSjDgqPX26yyX
         ZvjcUjAWd0f1J2iMs23WBPsWr9UxC1dqqTRX6RUXpFU0qfZCkbzObSQNpRyoEdLbycuJ
         53SDQ6yvIEUkgJGRBeQxmgcQMwiZd1DvOsAUMPCDhDnk9d2nROA+P4fhimgc7kSkmub4
         MrpLurFv3dE82YJP0ExNlmWHBTaN7lPjECkPjceHMcZCZ4czSio4mYLvDaSo9h9RIt2j
         2CLCTLpa6YOCPEpApEpcK2xkr9AkS+U2RWn1/vkklVs4LkXf47k7ObIW1DarR0ssannk
         6QJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fb1aYcSbpq+9iaeIeVo4QA9jJ6hhJT83G2zP5+xozbs=;
        b=YihR6IVPePMnZe4HnV1nh1Ldqn8kg1BZcy/Z3RwJHJJfCDQcPy1/dxPZRb9RaFn7El
         L6aTuRPCmt2x2MvX1iEMY966Q3nmvApSigARd140K4DVeoJlz/KfN5FGtgLErW+UXOT8
         g8t6ugIpTnUxijJOHWdBC23HGjG1NXH284kH8xH2uctLQ2E9QtB9OF1KoL64zIumA6an
         IX/InbZJIkw2WSeO+WYus/Px1Qsh4Epr2z3brJDFNxXENav70a/yi+65NkGSNLegaB3E
         J/V76KSX5C7je0dIcsQuEVhUBu/P1NxGjOMPnyC4etKASjZTqnCq1Je/NuDY0l3hDFUa
         QKzg==
X-Gm-Message-State: APjAAAWHNIE0oMlSYnRUo/jhwkpNmcuZ/eTFYtfWbtz7Pivb3QwP64Pz
        o7MBmZT/NYHZQrNzZlmI65r6q8TboBI=
X-Google-Smtp-Source: APXvYqzff6sJKilGEJW39S2vUAbOgiLqQa9sel9inqOQpL5mM8DbqO2+in5jdzxWiqHhD/VXwOUMkQ==
X-Received: by 2002:a1c:7517:: with SMTP id o23mr7738150wmc.34.1571830038540;
        Wed, 23 Oct 2019 04:27:18 -0700 (PDT)
Received: from mail.google.com ([104.238.174.53])
        by smtp.gmail.com with ESMTPSA id g11sm20566012wmh.45.2019.10.23.04.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 04:27:17 -0700 (PDT)
Date:   Wed, 23 Oct 2019 19:27:11 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jiri Kosina <trivial@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel-doc: trivial improvement for warning message
Message-ID: <20191023112709.dpc64xc3g3e7wks3@mail.google.com>
References: <20191020132323.29658-1-changbin.du@gmail.com>
 <20191021185406.GC9214@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021185406.GC9214@bombadil.infradead.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 11:54:06AM -0700, Matthew Wilcox wrote:
> On Sun, Oct 20, 2019 at 09:23:23PM +0800, Changbin Du wrote:
> > The message "Function parameter or member ..." looks weird.
> > 
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > ---
> >  scripts/kernel-doc | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/scripts/kernel-doc b/scripts/kernel-doc
> > index 81dc91760b23..cd3d2ca52c34 100755
> > --- a/scripts/kernel-doc
> > +++ b/scripts/kernel-doc
> > @@ -1475,8 +1475,13 @@ sub push_parameter($$$$) {
> >  		$parameterdescs{$param} = $undescribed;
> >  
> >  	        if (show_warnings($type, $declaration_name) && $param !~ /\./) {
> > -			print STDERR
> > -			      "${file}:$.: warning: Function parameter or member '$param' not described in '$declaration_name'\n";
> > +			if ($decl_type eq "struct" or $decl_type eq 'union') {
> > +				print STDERR
> > +					"${file}:$.: warning: $decl_type member '$param' not described in '$declaration_name'\n";
> > +			} else {
> > +				print STDERR
> > +					"${file}:$.: warning: $decl_type parameter '$param' not described in '$declaration_name'\n";
> > +			}
> >  			++$warnings;
> 
> How about instead ...
> 
> 		if (show_warnings($type, $declaration_name) && $param !~ /\./) {			if ($decl_type eq "struct")
> 				$msg = "struct member";
> 			elif ($decl_type eq "union")
> 				$msg = "union member";
> 			else
> 				$msg = "function parameter";
> 			print STDERR "${file}:$.: warning: $msg '$param' not described in '$declaration_name'\n";
> 
> (please excuse my perl, i am not a native speaker)
This removes some duplicated characters, but need to decalare a extra variable.
I am okay for both approaches. :)

-- 
Cheers,
Changbin Du
