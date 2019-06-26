Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB30C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 18:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AA7720663
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 18:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJosoKYj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfFZSoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 14:44:11 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44459 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfFZSoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 14:44:10 -0400
Received: by mail-qk1-f194.google.com with SMTP id p144so2529537qke.11
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 11:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uf9D69ZUuS+skkMSiMeQV2iLgR78IQAyJ44t60xXmbc=;
        b=iJosoKYj/TQ/QbKoxkaYY3gwVNTF12AgYb5ZMH+dJIG6yzYsGCixW1nuHdMEZLmeiF
         b2BEN4RERT8IfVl5LxP57H8JlJpLcCDzRIeMhx5AsE37lGBRKUmF+3+R96j1O3DfmQfG
         mCiw6CCZhz+uYg5PxsY2j8zAR3DbiirugG61rcix4l5GY7bhdg4MDeFh2cirSBI70w7H
         3GHdK9/m61R/ISHmzv3veQpM6vLNCNve5VeIqUxQFxZ7lv/VmcNLlHFGwjOWPMOGsvUL
         ursKIIUCJ82wNPKPrTvTbao8YQW2Lwy4tIQ5Pj+rQoSvB3CXQy0LjBeje5djb+6KF7d/
         5wVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uf9D69ZUuS+skkMSiMeQV2iLgR78IQAyJ44t60xXmbc=;
        b=XwztsR2G5dNy1Mr3Gj24brl18kogPRSAr1OmlKQU+6jNrMge1nZs3sw+K84go+aKCw
         4PQZ2zoaJRcgKNQSfvZuOxw+a+ag6TuDHlhyZva/hipfX8xSt+f9nv5Kpx6bp5QaHd8i
         NxKsUD9zVG9TuD8i0p5swWdvxZPeD4gW7W47+Fid2EyJdVmVl0Yy0jOJqAlw5jG6fKd3
         6fgc2U6WBGQc9kN3HCh/jcnNU4y0fOV0+AkGBCWBcAGVLGXDNS8dn0df9jdiOjFtq1Di
         YlzyVoAn1Ep+x+81cWfU/wjkISJAIkuMzjdsJjgFZtiO5ZjKCjFvTVOJ6hiHEkfusPef
         qwTA==
X-Gm-Message-State: APjAAAXfElmsbJusmcAewqzzEYMp7OiD4Iy/cveu6q/5FmUEoTmBO5Vy
        mSG5BQG5R9pyYn5MfUv+0Qfbmo+v
X-Google-Smtp-Source: APXvYqwZADhTzldFgW3vQNkYjWIe6nz96VbWcCbrjQHMlzL9y9hyRMMjBTldjT9rHMgRJVWhyJgrIQ==
X-Received: by 2002:a37:aa8e:: with SMTP id t136mr5427306qke.222.1561574649887;
        Wed, 26 Jun 2019 11:44:09 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([177.195.215.254])
        by smtp.gmail.com with ESMTPSA id 6sm8558905qkg.108.2019.06.26.11.44.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 11:44:09 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5EDA541153; Wed, 26 Jun 2019 15:43:59 -0300 (-03)
Date:   Wed, 26 Jun 2019 15:43:59 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andi Kleen <andi@firstfloor.org>, jolsa@kernel.org,
        kan.liang@intel.com, linux-kernel@vger.kernel.org
Subject: Re: Some bug fixes for perf stat metrics
Message-ID: <20190626184359.GB3902@kernel.org>
References: <20190624193711.35241-1-andi@firstfloor.org>
 <20190625092317.GA20028@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625092317.GA20028@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jun 25, 2019 at 11:23:17AM +0200, Jiri Olsa escreveu:
> On Mon, Jun 24, 2019 at 12:37:07PM -0700, Andi Kleen wrote:
> > Fix some bugs and regressions in perf stat --metrics support.
> > 
> > Also available in 
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/ak/linux-misc perf/metric-fixes-1
> 
> looks good to me
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Thanks, applied.

- Arnaldo
