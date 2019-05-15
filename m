Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4A0C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 08:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67CA720862
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 08:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbfEOIQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 04:16:59 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33365 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfEOIQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 04:16:58 -0400
Received: by mail-qt1-f194.google.com with SMTP id m32so2302669qtf.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 01:16:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fgcbi+I+ApUj6lK5BMoQniFPniwMRp5CE2A76F6GDCY=;
        b=C9yVr5rqxconl8dT1xTu193iOcM85yKkFS/DY5o50TZnVgPF8sIfjmrsDmQiUytxpo
         iikS50RTBTAwtIA+QVb5rsFG7wtfz80+vsILaNJpfwMJ0PZtZfHyBJlfCocWTetFFVMa
         4gXpMfCYVWdusSGOq0mhj9ljHAD0+RRURAFczh3zG3hpwatLmq+46T7mdaNMhz/9uHZL
         sCNPRp/pdiFqJ+xLVJFQEojz3gFzON14okF4d+yKzzN3ojQcuLmYFgzdw3tsh+Ms+0YE
         9vKM7cnYanT84qXoHIYpTMnrkGmX/lec0j7Q5ZGLuYCEdIW1Pbnw/tdYXKMc2mNPkLrE
         5RPA==
X-Gm-Message-State: APjAAAXkClHd4SE5kY2oAIsmZl2sVUvFx/UIZ15g8p9js/W4hbxkVqWF
        B72NBSLK7oB3y10R+zqqlFsN1KPOu2mZhIShJwo=
X-Google-Smtp-Source: APXvYqwgMePXe1ACH3tNN3bPaz1CHFs1on6Saxqxv+vADc9fvaQmk5mkqQiSHO/jxgsFbdBj0pQrlVqLqEO6VpNjF6w=
X-Received: by 2002:ac8:2d21:: with SMTP id n30mr32912118qta.96.1557908217673;
 Wed, 15 May 2019 01:16:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190512012508.10608-1-elder@linaro.org> <20190512012508.10608-13-elder@linaro.org>
In-Reply-To: <20190512012508.10608-13-elder@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 15 May 2019 10:16:41 +0200
Message-ID: <CAK8P3a3v2fzSBmYk1vG7sKJ9jnAWGt_u91EuLC7f5jq_PqrKXQ@mail.gmail.com>
Subject: Re: [PATCH 12/18] soc: qcom: ipa: immediate commands
To:     Alex Elder <elder@linaro.org>
Cc:     David Miller <davem@davemloft.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        syadagir@codeaurora.org, mjavid@codeaurora.org,
        evgreen@chromium.org, Ben Chan <benchan@google.com>,
        Eric Caruso <ejcaruso@google.com>, abhishek.esse@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 12, 2019 at 3:25 AM Alex Elder <elder@linaro.org> wrote:

> +/* Initialize header space in IPA local memory */
> +int ipa_cmd_hdr_init_local(struct ipa *ipa, u32 offset, u32 size)
> +{
> +       struct ipa_imm_cmd_hw_hdr_init_local *payload;
> +       struct device *dev = &ipa->pdev->dev;
> +       dma_addr_t addr;
> +       void *virt;
> +       u32 flags;
> +       u32 max;
> +       int ret;
> +
> +       /* Note: size *can* be zero in this case */
> +       if (size > field_max(IPA_CMD_HDR_INIT_FLAGS_TABLE_SIZE_FMASK))
> +               return -EINVAL;
> +
> +       max = field_max(IPA_CMD_HDR_INIT_FLAGS_HDR_ADDR_FMASK);
> +       if (offset > max || ipa->shared_offset > max - offset)
> +               return -EINVAL;
> +       offset += ipa->shared_offset;
> +
> +       /* A zero-filled buffer of the right size is all that's required */
> +       virt = dma_alloc_coherent(dev, size, &addr, GFP_KERNEL);
> +       if (!virt)
> +               return -ENOMEM;
> +
> +       payload = kzalloc(sizeof(*payload), GFP_KERNEL);
> +       if (!payload) {
> +               ret = -ENOMEM;
> +               goto out_dma_free;
> +       }
> +
> +       payload->hdr_table_addr = addr;
> +       flags = u32_encode_bits(size, IPA_CMD_HDR_INIT_FLAGS_TABLE_SIZE_FMASK);
> +       flags |= u32_encode_bits(offset, IPA_CMD_HDR_INIT_FLAGS_HDR_ADDR_FMASK);
> +       payload->flags = flags;
> +
> +       ret = ipa_cmd(ipa, IPA_CMD_HDR_INIT_LOCAL, payload, sizeof(*payload));
> +
> +       kfree(payload);
> +out_dma_free:
> +       dma_free_coherent(dev, size, virt, addr);
> +
> +       return ret;
> +}

This looks rather strange. I think I looked at it before and you explained
it, but I have since forgotten what you do it for, so I assume everyone else
that tries to understand this will have problems too.

The issue I see is that you do an expensive dma_alloc_coherent()
but then never actually use the pointer returned by it, only the
dma address that cannot be turned back into a virtual address
in order to access the data in it.

If you can't actually use payload->hdr_table_addr, why even allocate
it here?

     Arnd
