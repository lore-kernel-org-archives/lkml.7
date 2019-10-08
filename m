Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84457C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 11:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5756E20673
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 11:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="ft1ONni5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730671AbfJHLmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 07:42:50 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34024 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730118AbfJHLmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 07:42:50 -0400
Received: by mail-qk1-f193.google.com with SMTP id q203so16368402qke.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 04:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=3JJSHu9FsmPxAujVouhMDsGNkk6sBiZ/QmGwiiONFB4=;
        b=ft1ONni5tzPFm7vpcdDKsmvlZcXVOpt9il2RREKA5mDs/iXlDAWt12DMHLjZ40/uLa
         W67IwIJbw0KNkBqIv4mqZyBbImfLaMu0nTzVSEFCPsLy8grCpjixyboBqo9XE2IH4tVd
         hGjwfHEsKsBMR5ENiBLo+UUOk6omMbdmasKrLXV3aEjP9VAjG1cdDLfdFo7qNYcJWoed
         gfSiltjTPQqJJzwlxjca6gnd4c0n7twpHnJ+3DTdcwWAOFKCl2oc0uPUxGLRuRIDyNjK
         5dSd5S5fEJI+6sKBBNyzSXaremLmFju9Z/ytR3YTieR9ADzSZj1Br7Zm7qBD0AloT/mj
         ub5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=3JJSHu9FsmPxAujVouhMDsGNkk6sBiZ/QmGwiiONFB4=;
        b=r+DAhLW8QDDziyut7uzVStflwSI3WSaRNEId7MypTZJ2y4tbhXzwHAXLaKNn/irgg1
         7pAqH/gr7NmktxRKxVDEegTKFlrL+MyXqQieIGm5a/jzV7P/uclGtDe2wfy7LG9WS63T
         c14XBmdDuqe+QA3DNf9ZMbweMQqGDi3IX6g0m93LcsJqy6PUD1z9eYxqEJy0PadCWy9f
         Q4Qf16rfIh/FpE3xM120ZSeax7rvLEIn0rBlbX7H11HmbxRI+rMSI8gIVeFLDGNGMWtj
         7uD3ZZDAAD4LsFEPWERR628aeN2DSrET+yR1symEXH5EQi3L+TxuS8SpZ58Ek0CXenaj
         wzxg==
X-Gm-Message-State: APjAAAV26bJ/bXqEH9fEhTYDTa3RQNfuag0GHg06fXazJG4QZEng4l0K
        vocZJvSsPP2NC3HZcbzD9LGIFw==
X-Google-Smtp-Source: APXvYqyvnmDGXV158zZXzurCCRh8+3D7IL8S9DfULYqcaPIxyxkKvDspSY364oomPYuJWS2qYqpqQA==
X-Received: by 2002:a37:bec1:: with SMTP id o184mr28322315qkf.479.1570534969079;
        Tue, 08 Oct 2019 04:42:49 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id g19sm11133394qtb.2.2019.10.08.04.42.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2019 04:42:48 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] kasan: fix the missing underflow in memmove and memcpy with CONFIG_KASAN_GENERIC=y
Date:   Tue, 8 Oct 2019 07:42:47 -0400
Message-Id: <D2B6D82F-AE5F-4A45-AC0C-BE5DA601FDC3@lca.pw>
References: <1570532528.4686.102.camel@mtksdccf07>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        wsd_upstream <wsd_upstream@mediatek.com>
In-Reply-To: <1570532528.4686.102.camel@mtksdccf07>
To:     Walter Wu <walter-zh.wu@mediatek.com>
X-Mailer: iPhone Mail (17A860)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 8, 2019, at 7:02 AM, Walter Wu <walter-zh.wu@mediatek.com> wrote:
>=20
> I don't know very well in UBSAN, but I try to build ubsan kernel and
> test a negative number in memset and kmalloc_memmove_invalid_size(), it
> look like no check.

It sounds like more important to figure out why the UBSAN is not working in t=
his case rather than duplicating functionality elsewhere.=
