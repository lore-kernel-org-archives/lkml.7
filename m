Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0DD4C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 07:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87C23206A3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 07:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rL1R5dEG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbfEQH1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 03:27:42 -0400
Received: from mail-pg1-f169.google.com ([209.85.215.169]:38398 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727357AbfEQH1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 03:27:42 -0400
Received: by mail-pg1-f169.google.com with SMTP id j26so2887969pgl.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 00:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5yR7w+lbXREb1V+QECtjDDonB2NG2+mD0zE8iEbLsOA=;
        b=rL1R5dEGxFf0mAiouBM4WyIyJZ8lQ/FFAJS1ZztuHLBBhU/AuQSJk59uh2/Naurhzu
         JsZaG5ziu7sOP04pfroQYmEnw+an5tgyQ3pQjx680Ve6Q0NUGh94x33CUPaabRViKSL8
         Hys5i+cUGtBGyBGtnWDDzfhGLFa4Kyp41YBM7y3s8z6Qlnp5DIWH19wR2dPsyCcWK5lQ
         o0klD35f6BhlECxzjiBlm3d17a6dMOHRZi0LT2f8Y1ymTYC3KwPaSiiQqnUpV/HZ/V0J
         +Lo46zzei2RJNXEhbjv8u8WmdckJw8wSHi1xjVxzErXCdn7OacgK8Edo1JvwuCif/SrY
         AxZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5yR7w+lbXREb1V+QECtjDDonB2NG2+mD0zE8iEbLsOA=;
        b=g4gDBN7eyjEySrkyrAHW6+dVOAfDwV4ex763t8m0kRZMvDTVHs1GuyP1D/pRq9ayXV
         ZLJVAcBhUXsiNNFyhy22pm02W2yOhbeVGzkbzILD40ZxpLCawEAwoxqAaOE/NtP7mBHO
         B2nLr0pidA4WR5E2lGg7a9FAkclpbFGgHIlM3D5DhVpBjZcItc54fI8A/2VuZdmfCfhK
         2b05ZXYsz1DjSZw9cMwsfmO+G6A996q7WhLWkwaxAY8HcuYCYE094a2uMWEh3K86SEfj
         xZzrk+2wTl+RTCyq/VV+QMXMY+DNAYSm497AfZaVJoeVeW6fWg8JERVlkyZElbUBkVHI
         pNzA==
X-Gm-Message-State: APjAAAVsqqJIupdKRALYGtYjfwbHM8R0beSRiXAl2plbH6TjSDmHoQtK
        pLeBcGhsv4UNGa+c+x4batY=
X-Google-Smtp-Source: APXvYqwkpkqsGtVIR2m+JggYHRaeSu01PUNRAiPSAH7+euE+tdrLQfGM8RMw5R18pbOHoltUL9EtUQ==
X-Received: by 2002:a65:64da:: with SMTP id t26mr55379408pgv.322.1558078061730;
        Fri, 17 May 2019 00:27:41 -0700 (PDT)
Received: from localhost ([175.223.38.122])
        by smtp.gmail.com with ESMTPSA id m12sm3674967pgi.56.2019.05.17.00.27.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 May 2019 00:27:40 -0700 (PDT)
Date:   Fri, 17 May 2019 16:27:37 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: drm/nouveau/core/memory: kmemleak 684 new suspected memory leaks
Message-ID: <20190517072737.GA651@jagdpanzerIV>
References: <20190517061340.GA709@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517061340.GA709@jagdpanzerIV>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (05/17/19 15:13), Sergey Senozhatsky wrote:

> ... but most likely it's utterly wrong.
> 

JFI, I removed kmemleak annotation and added the following
thing:

@@ -360,6 +360,7 @@ gp100_vmm_valid(struct nvkm_vmm *vmm, void *argv, u32 argc,
                        return -EINVAL;
                }

+               kfree(map->tags);
                ret = nvkm_memory_tags_get(memory, device, tags,
                                           nvkm_ltc_tags_clear,
                                           &map->tags);

	-ss
