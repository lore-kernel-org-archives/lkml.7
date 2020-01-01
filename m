Return-Path: <SRS0=1Df5=2W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0063BC2D0CE
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 00:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5EAB206E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 00:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uAoUWv2o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbgAAAaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 19:30:22 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:39814 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbgAAAaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 19:30:22 -0500
Received: by mail-qv1-f65.google.com with SMTP id y8so13826090qvk.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Dec 2019 16:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DzYpuP8XE5ny7T3YPWMLSccVrAcJzUtTmsam6QD4s5c=;
        b=uAoUWv2oO5dauIciJEEH9c7CQNyrJEBUSZcTjmxQptSVhJT92vrrVIZ/0HVv83myta
         hJgQnHIWXV6/RyW1o4Td/leuheieusIfE3wBYagrcoy0wJ8Qaw5MQL8XifvrK5qrXxyv
         wvcd7z/gjVhSGYdCnfpg2te6DHsblXVtaSVacT5e4lK1v0ym0nHLdvshQo2FT6RhlPF4
         fi0lD+wdTMPyS0UGW8/h4gk6uL3bjNLt/gPewCmtHsKU5bd8VQyVx+gbqsbpbPSzPkUj
         Kx9WivTn55IoxABYCEKFlDXdIiVMwXhCYzgDo+SlrH6f1xWDdGhFEHjiwtnmZeS/e0Xb
         rY6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=DzYpuP8XE5ny7T3YPWMLSccVrAcJzUtTmsam6QD4s5c=;
        b=i8EbTFxs/E+AtIQZy3AMR7V+M3Yc929SWhzRmP75pbwN6Tyvgxw0veD9ii6JpuVe8U
         S+PfCL3zK0xCsJmS74JZeP8m3iQiAXSBnxAMsNkMNyafl2km5DZu4q7UitA2RG0D251Z
         78jqcei4tYDU3yBtBQXWWQr84TGfLwAjPz9+7qmGHlcBNmjW5mz75eSFLeykCk1dca1B
         Zg829UszuR+ZDerutb/DFPE8Qprp723I8dk6uupjmvGWyMW9svQ/JSJdv8XMutksLPxr
         f40PXV5C6a2IS2vBtyPy4XxUNx1j6REdUtEEHkNAXHjoqLbR0sBzZOaeJd12MRTVhQcT
         gSRA==
X-Gm-Message-State: APjAAAWGbVTErOgv5iB1T24zcUqkf+dIelK8S8PKOKqrsgHgFldydkBR
        NWZZHmFuqv0fAa01C/LbyTScK1+Ru/8=
X-Google-Smtp-Source: APXvYqyUqREWFDhoFMB/iaSyPJiqnGfJ0GTQR3A8sLV9tt9TCxt49N1uG6GfYYIlbHLxZi7sBUBJyQ==
X-Received: by 2002:ad4:40c7:: with SMTP id x7mr58529268qvp.176.1577838621182;
        Tue, 31 Dec 2019 16:30:21 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id 4sm13805769qkv.44.2019.12.31.16.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Dec 2019 16:30:20 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 31 Dec 2019 19:30:19 -0500
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, youling257@gmail.com
Subject: Re: [PATCH] early init: open /dev/console with O_LARGEFILE
Message-ID: <20200101003017.GA116793@rani.riverdale.lan>
References: <20191231150226.GA523748@light.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191231150226.GA523748@light.dominikbrodowski.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 31, 2019 at 04:02:26PM +0100, Dominik Brodowski wrote:
> If force_o_largefile() is true, /dev/console used to be opened
> with O_LARGEFILE. Retain that behaviour.
> 

One other thing that used to happen is fsnotify_open() -- I don't know
how that might affect this, but it seems like the only thing left that's
different.
