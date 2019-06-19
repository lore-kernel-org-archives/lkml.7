Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDAB5C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 12:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91BBD206E0
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 12:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560948702;
	bh=FVwr64TDul3GV8/9VplZgVnhR38LbzHnIJkGrIGZiUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vF5dkAE0L7Yy0o++10ixgHbKsxpEAPuOD76/YzK2PIshgLgGN+lSYo/vVk0ESaVS1
	 yUyeLu6aeSZaO+QCTIDrGuOXGq0zJDWtb+mcp9NY+B0BmnJTd4PN3beNAvwWKaCrvj
	 iiXwrLIplA1w3AqGQ5Pis9mUonXmdvnh63kP3m6g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731855AbfFSMvl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 08:51:41 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33591 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbfFSMvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 08:51:41 -0400
Received: by mail-lf1-f66.google.com with SMTP id y17so12057038lfe.0;
        Wed, 19 Jun 2019 05:51:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P+ogsiHO7op0ZafI5F7vAc1Eympl/BmvaLFZ45AJXY4=;
        b=Ve6SyddFcyqtu41Dc49kgfK586JZch+mqXZ0QKLCn87jEvwL4bnchbBmX5HTDTFKgk
         gOZcIHBZU2s2+lE0TaMrGHwOqByTGDUDK+8WKAfmAx+AYk8ZMV/igTstMdjon6oo8JPq
         2Gk4FgXHCvnp8aBKTN4UReaFFPVnAytQ+W/HEs5lUXoDblBncAZ1m9LD6/FF5FkbeY+C
         4wW/hmzc+aFok5lTx+HgajaYfqbAEdPjTqpAYonpi7V5hDy7TWO2SVu7AY7/pz4scRGI
         Bt/hnd5NaaD97PvfCieX3G4l8xF225/2XwcKBxgmHe4htpoMDxZpUb2KYDUb02KUImzP
         9zWA==
X-Gm-Message-State: APjAAAXM+pGm139d7/XWR+5WfeboVV4Qt+CjQe6snsx7Ok4n2f5UVtmm
        cuTuofRlPppghk7kPiVvqQI=
X-Google-Smtp-Source: APXvYqzjtf6iQdyoCpJJDR23C1LNfZI0dR42n65ZtrIY3OGWiu0kca4Qd4CUMhO75m7rKCYyNqiX/Q==
X-Received: by 2002:ac2:59c9:: with SMTP id x9mr4567081lfn.52.1560948698566;
        Wed, 19 Jun 2019 05:51:38 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id p15sm3111330lji.80.2019.06.19.05.51.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 05:51:37 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92)
        (envelope-from <johan@kernel.org>)
        id 1hda3r-0001f7-7Y; Wed, 19 Jun 2019 14:51:35 +0200
Date:   Wed, 19 Jun 2019 14:51:35 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Stefan Achatz <erazor_de@users.sourceforge.net>
Subject: Re: [PATCH 04/14] ABI: better identificate tables
Message-ID: <20190619125135.GG25248@localhost>
References: <cover.1560477540.git.mchehab+samsung@kernel.org>
 <6bc45c0d5d464d25d4d16eceac48a2f407166944.1560477540.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bc45c0d5d464d25d4d16eceac48a2f407166944.1560477540.git.mchehab+samsung@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 11:04:10PM -0300, Mauro Carvalho Chehab wrote:
> From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
> 
> When parsing via script, it is important to know if the script
> should consider a description as a literal block that should
> be displayed as-is, or if the description can be considered
> as a normal text.
> 
> Change descriptions to ensure that the preceding line of a table
> ends with a colon. That makes easy to identify the need of a
> literal block.

In the cover letter you say that the first four patches of this series,
including this one, "fix some ABI descriptions that are violating the
syntax described at Documentation/ABI/README". This seems a bit harsh,
given that it's you that is now *introducing* a new syntax requirement
to assist your script.

Specifically, this new requirement isn't documented anywhere AFAICT, so
how will anyone adding new ABI descriptions learn about it?

> Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  Documentation/ABI/obsolete/sysfs-driver-hid-roccat-pyra   | 2 +-
>  .../ABI/testing/sysfs-class-backlight-driver-lm3533       | 6 +++---
>  Documentation/ABI/testing/sysfs-class-led-driver-lm3533   | 8 ++++----
>  Documentation/ABI/testing/sysfs-class-leds-gt683r         | 4 ++--
>  Documentation/ABI/testing/sysfs-driver-hid-roccat-kone    | 2 +-
>  5 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/ABI/obsolete/sysfs-driver-hid-roccat-pyra b/Documentation/ABI/obsolete/sysfs-driver-hid-roccat-pyra
> index 16020b31ae64..5d41ebadf15e 100644
> --- a/Documentation/ABI/obsolete/sysfs-driver-hid-roccat-pyra
> +++ b/Documentation/ABI/obsolete/sysfs-driver-hid-roccat-pyra
> @@ -5,7 +5,7 @@ Description:	It is possible to switch the cpi setting of the mouse with the
>  		press of a button.
>  		When read, this file returns the raw number of the actual cpi
>  		setting reported by the mouse. This number has to be further
> -		processed to receive the real dpi value.
> +		processed to receive the real dpi value:
>  
>  		VALUE DPI
>  		1     400

Johan
