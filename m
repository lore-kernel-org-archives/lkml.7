Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85534CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 22:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58BED2084C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 22:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="kblqZkpK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388156AbfJVWUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 18:20:05 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42526 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387767AbfJVWUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 18:20:04 -0400
Received: by mail-lj1-f194.google.com with SMTP id u4so4733079ljj.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 15:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=eJeiOHf0qMrqlF/fxKjCis2VKW2qM0EkZCFmwOD6UAY=;
        b=kblqZkpKk9Zv8+vkRFatupFOSxOn+KEJuyarb+K8rHZ/PuJhhR0Ed/8kh+trzE+yE5
         HXws66SwIuCM+7LckDSHL7N4WKeHP3ryW4/5zdszebvixBPYOEus0ggkgOArT9A1VUlq
         MBctIzg0ofDuYIPuGGjG7wg22DTTVgAAuKw6iNFdj1NLMRrhYSiXV5dK7d4CjsWt2OTe
         pBGDl7CCrzI63IYMbC/nPICyLBw5VqVUvhSIUmGZ2fqo+2k6SnB09abYgnmKRMfEnuig
         +nm1+fqNM9DOl7GLGS8F3n6TWEdLT8DtJdd7GvGGepzxTYvys+4PqHUMCqo3KkIIACvd
         XYIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=eJeiOHf0qMrqlF/fxKjCis2VKW2qM0EkZCFmwOD6UAY=;
        b=mr8+bpFBJwAD7IrTIXHCO/2peJRwtSkDXfszWdm1FIILG9PU9HlgNs+3SX26FnrOvk
         FRtPHbQbn3S/NV8z3xs0w4zy0v1MuJ+rtQ+c6Xlfl9WpbTeFJT3q2msb/sCu4TA0HQoY
         CGwENc135R6Xv6+vYYEOqVeuPA59meSHGnOUe6IjS+JjAI6f0tehnFhnXD9LkYWmBCG9
         YNq+76aJZtUsRnEJuVJkk1TMgFhh/ngyRRxhmMonXfGxr8pr/FfSYdqzaxUCF9ccikdW
         y92lrnLKQdEIL8MuN9cN/oUSAw0/8ENxXwoG8JLNmcDWvGY0fwZpfoxAeFPsvVogMZ0K
         paSw==
X-Gm-Message-State: APjAAAUGWYVuZxcur4weYmG1lxOHIROeHqCdt3lp/wdVLLU00YfHFDSd
        gC0HGgN5bMRgW6uU4hp10oihxa/pFW4=
X-Google-Smtp-Source: APXvYqygfc/fvNSdOubo3mFfaZ2INJ9KgK0gK/dRspdCWOAaWW0QuhW0oG93R+xgpeYR28cfxYUKew==
X-Received: by 2002:a2e:b4ee:: with SMTP id s14mr20399148ljm.88.1571782802349;
        Tue, 22 Oct 2019 15:20:02 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id h21sm1583836ljl.20.2019.10.22.15.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 15:20:01 -0700 (PDT)
Date:   Tue, 22 Oct 2019 15:19:54 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
Cc:     linux-kernel@lists.codethink.co.uk,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipv6: include <net/addrconf.h> for missing declarations
Message-ID: <20191022151954.2973f774@cakuba.netronome.com>
In-Reply-To: <20191022144440.23086-1-ben.dooks@codethink.co.uk>
References: <20191022144440.23086-1-ben.dooks@codethink.co.uk>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Oct 2019 15:44:40 +0100, Ben Dooks (Codethink) wrote:
> Include <net/addrconf.h> for the missing declarations of
> various functions. Fixes the following sparse warnings:
> 
> net/ipv6/addrconf_core.c:94:5: warning: symbol 'register_inet6addr_notifier' was not declared. Should it be static?
> net/ipv6/addrconf_core.c:100:5: warning: symbol 'unregister_inet6addr_notifier' was not declared. Should it be static?
> net/ipv6/addrconf_core.c:106:5: warning: symbol 'inet6addr_notifier_call_chain' was not declared. Should it be static?
> net/ipv6/addrconf_core.c:112:5: warning: symbol 'register_inet6addr_validator_notifier' was not declared. Should it be static?
> net/ipv6/addrconf_core.c:118:5: warning: symbol 'unregister_inet6addr_validator_notifier' was not declared. Should it be static?
> net/ipv6/addrconf_core.c:125:5: warning: symbol 'inet6addr_validator_notifier_call_chain' was not declared. Should it be static?
> net/ipv6/addrconf_core.c:237:6: warning: symbol 'in6_dev_finish_destroy' was not declared. Should it be static?
> 
> Signed-off-by: Ben Dooks (Codethink) <ben.dooks@codethink.co.uk>

Applied, thanks!
