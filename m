Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB27FC5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 20:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B29C2084D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 20:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fIDblM9z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732173AbfKFUKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 15:10:08 -0500
Received: from mail-qv1-f51.google.com ([209.85.219.51]:46811 "EHLO
        mail-qv1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727143AbfKFUKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 15:10:08 -0500
Received: by mail-qv1-f51.google.com with SMTP id w11so1976724qvu.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 12:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZFsu0pmlFiKmm4hrpiSsvMTP9LV+BlHH+n6QKuLWpto=;
        b=fIDblM9z76ZjkJu2d/Aw95qJtqZhXGqIYp91dntO/dXwaDaQ4n5ZgP0GHUzn2g4InX
         MBts4SAiCnijiDfyAruw5n1cFzOSN0WCDh8GEUk8Za0ZVHx21pRqq54vYYxwYTSPRyQ+
         3kTHHAS0YYjl4fFOeAG6bx9INW05eH82HN265qdF3YPFx46XbYr/X+91IhL0OoRMsRHI
         j4aFD5vSEOPaXhRE2u7lIhcVlgM2yUpBeXhnEJnMInHBnT0+KDpYS23xbNdz7Qx+XvB1
         TIH8nhfmnsrRUsx6fS2f59nZv8PQV8mhubJEn+lnZkppXGOZsJ3eiVUWxo4v7YhZJN7n
         fg5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZFsu0pmlFiKmm4hrpiSsvMTP9LV+BlHH+n6QKuLWpto=;
        b=T5ZCLft2tpkX8IZF/edwc5/HAAOuM+Xs+RmZy/TYnO818gkzDgOVe4KeakewoB8NMD
         21yl8lJyw+LRROAzTAxqts0SxuiTQX+7lWzysINFhqdG+Wv80+PYfIYSOlWIVGvqa366
         RvTnpIw0pFhqvfPq1oDwBYqMKkY4FK+T/6K6X7K5SSTwN+Jcv86hWAvqh+3BA9liG/wS
         okw0m1mpPnNK1JeLiveCl59/AO0Ge76H4tTFvnv0cL+STO2CyboR91/aBko3oSETQ9P4
         eMaXmRqst3AQVdqRJeSHrfI90eJV8t9hKRp0h6kfNo9q4LL0x5YnntKuyXe9ZH3GS3zL
         PrHQ==
X-Gm-Message-State: APjAAAXMGvf9tkh4RnZQ9W0ApZEt4ryb4SGu98/UADgxhumZwbRPmTU3
        mM/Y2R9UwCkNWUHYwxoxmmpZGFU+Xjs=
X-Google-Smtp-Source: APXvYqyivRZ8/k99lADUE3jjxJToViqm2NiCylVlbJ+DNLmVn8nTw258JV0EdmVHCF0WJo+6FK4aQw==
X-Received: by 2002:a0c:b064:: with SMTP id l33mr4174633qvc.34.1573071006950;
        Wed, 06 Nov 2019 12:10:06 -0800 (PST)
Received: from quaco.ghostprotocols.net (187-26-100-98.3g.claro.net.br. [187.26.100.98])
        by smtp.gmail.com with ESMTPSA id f23sm4305418qkh.94.2019.11.06.12.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 12:10:06 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C928840B1D; Wed,  6 Nov 2019 17:09:59 -0300 (-03)
Date:   Wed, 6 Nov 2019 17:09:59 -0300
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [BUGFIX PATCH 4/4] perf probe: Skip overlapped location on
 searching variables
Message-ID: <20191106200959.GE13829@kernel.org>
References: <157241935028.32002.10228194508152968737.stgit@devnote2>
 <157241938927.32002.4026859017790562751.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157241938927.32002.4026859017790562751.stgit@devnote2>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Oct 30, 2019 at 04:09:49PM +0900, Masami Hiramatsu escreveu:
> Since debuginfo__find_probes() callback function can be called
> with  the location which already passed, the callback function
> must filter out such overlapped locations.

Thanks, tested before and after and applied,

- Arnaldo
