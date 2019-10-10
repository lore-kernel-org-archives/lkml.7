Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB040C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 07:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59102218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 07:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dSJYmIks"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733179AbfJJHiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 03:38:12 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:25177 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733026AbfJJH22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 03:28:28 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20191010072824epoutp04f2143e679af554d8be9ef770c502fb54~MOILV2ZRb1382113821epoutp04l
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 07:28:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20191010072824epoutp04f2143e679af554d8be9ef770c502fb54~MOILV2ZRb1382113821epoutp04l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1570692504;
        bh=UiZTFG4nh7uUFL+yJYVGYD1fL0gKphicORsZRSDFGjg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=dSJYmIks1y1+B3Z7puRz1mrnzIrNAQq44Q/EKMPPOyIBJkye/6b15lGTQx4zxXwQN
         pUyFdf3Fod5bdY9tQ2EBA2IIbrDLIlI7CTFFU3rIYBbyT7sCB5bBm1zz1vT4g4PJqL
         fQVSsmAk2xketr8a0yZPMM1Fq9TAgW0dY6JAcwh4=
Received: from epsnrtp5.localdomain (unknown [182.195.42.166]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191010072824epcas1p250a5aee3160021fd58c211986b965a2f~MOILFRaic3258032580epcas1p2s;
        Thu, 10 Oct 2019 07:28:24 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.152]) by
        epsnrtp5.localdomain (Postfix) with ESMTP id 46pjP32BW4zMqYkV; Thu, 10 Oct
        2019 07:28:23 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        21.49.04144.B8DDE9D5; Thu, 10 Oct 2019 16:28:11 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191010072810epcas1p1c9d229bd91b0f6734398da90ef55cc2f~MOH_U-DEQ1777517775epcas1p1Y;
        Thu, 10 Oct 2019 07:28:10 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191010072810epsmtrp28743eccd7398ccaf7e60039c82d22c63~MOH_UUQmK1416514165epsmtrp23;
        Thu, 10 Oct 2019 07:28:10 +0000 (GMT)
X-AuditID: b6c32a35-2c7ff70000001030-37-5d9edd8b2a06
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7F.E3.04081.A8DDE9D5; Thu, 10 Oct 2019 16:28:10 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191010072810epsmtip12df8456ace3614267b8e2b25929c537e~MOH_HHxE22390323903epsmtip1L;
        Thu, 10 Oct 2019 07:28:10 +0000 (GMT)
Subject: Re: [PATCH] extcon: sm5502: Clear pending interrupts during
 initialization
To:     Stephan Gerhold <stephan@gerhold.net>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <328ccd73-2ceb-2e3f-524c-3fd950ccbf09@samsung.com>
Date:   Thu, 10 Oct 2019 16:33:12 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191008105434.119346-1-stephan@gerhold.net>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SeUgUcRTH+e2s4yht/Vw1X1K6TlQkqTu5a6upJYltKWR0ibDYoNOuuFc7
        a2kieER5LB1koJuWB4JJB5qKlSZoWdKdRGIY0UGl0Z2plbTjKPnf5733fdfv9yhCXkT6U5lm
        O2czs0aa9JR29K1WhpSPnNUp6x1+msFr1aTmeWETqRmqUW0ktEdqN2iPtTUj7ffWgGQiNSva
        wLEZnE3BmdMtGZlmfQyduCNtU5o6QsmEMJGadbTCzJq4GDo+KTkkIdPoakMrDrDGbJcrmeV5
        Oiw22mbJtnMKg4W3x9CcNcNojbSG8qyJzzbrQ9MtpihGqVyrdgn3ZhnuDW23dgXk3Bl0ogJU
        CWXIgwKsgpYLZZIy5EnJcSeC0uZhJBrfEPwoapSKxjiCnolJNJfy9/AlqcBy3I3g9VdeFH1G
        0FpYNxPwxrtg6teQiynKB++E9j6V4CawAqZetLoJTOJg6Hk/RAq8CAfB04nXM/VlOBa+HL3j
        LrAUr4CRsfeEUMYXp8Ddn6wo8YKBqjcznTxwFHQ+nHYXy/vB8JtzEpEDobj9DCGMBriLhBvl
        l0hx/niYqrs6y94wervNXWR/+P6pe9afB+cHbpJicgmCtp5HbmIgHHoaT0mEgQi8Gi5fCxPd
        QXD1dw0SGy+ETz8dboIEsAxKjshFyXIYfDkiEXkJNBwtJU8g2jlvHee8FZzzVnD+b1aLpM1o
        MWflTXqOZ6zM/K9uRTP3F6zuRBUPknoRphC9QGYYqNHJ3dgDfK6pFwFF0D6yeme1Ti7LYHMP
        cTZLmi3byPG9SO167JOEv2+6xXXNZnsao14bHh6uUTERaoah/WRafYFOjvWsncviOCtnm8uT
        UB7+BWjlo4UPn6keN+6ZLtlao0gs8vV0lOubvxzGAQ2mvHvjlVt6HXFP1jQl1TmZb6t88t99
        Lej4WF7xh3OsCpj8UHz/w7bNlR2jloawBSmvvK6YfujiFPl8l6qq+OJ4Syph27dEkxN4ffee
        lsZl+9ePje1b+iDr1uhxOfW2P+H0wYjd/dVGWsobWCaYsPHsP7gBVkOVAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPLMWRmVeSWpSXmKPExsWy7bCSnG7X3XmxBu1rFS0u75rDZnG7cQWb
        xY25Jg7MHm0L7D36tqxi9Pi8SS6AOYrLJiU1J7MstUjfLoEr48yNwII9chUnLs9ibGCcIdHF
        yMkhIWAi8bdlHUsXIxeHkMBuRomrL6+zQiQkJaZdPMrcxcgBZAtLHD5cDFHzllHiWsNSRpAa
        YYFQiV/fb7CA2CICIRLXTi1kBrGZBRQkft3bxArR0MsosXndVrAEm4CWxP4XN9hAbH4BRYmr
        Px6DDeIVsJP40H6CHcRmEVCVuPv6BVi9qECExPPtN6BqBCVOznwCtoxTwEpix/l/7BDL1CX+
        zLsEtVhc4taT+UwQtrxE89bZzBMYhWchaZ+FpGUWkpZZSFoWMLKsYpRMLSjOTc8tNiwwzEst
        1ytOzC0uzUvXS87P3cQIjgYtzR2Ml5fEH2IU4GBU4uHNODk3Vog1say4MvcQowQHs5II76JZ
        c2KFeFMSK6tSi/Lji0pzUosPMUpzsCiJ8z7NOxYpJJCeWJKanZpakFoEk2Xi4JQCxs3S09v7
        qu9/0WZ4sU+98Wz/tAstuQUiHNwHovyz8nefW8fJcXfxpYsa2UrNts0bpFi0rNom6bx5+k+y
        y+RFR8ivA9bX26s+Hz5XHJlfENdcKLDxp3fHyz8CR+RvL54e6d7XwPpR2SH39cq+/MYnZ3wW
        h1f+lDm0fqHUBzYjGc9b0jXmsls2KbEUZyQaajEXFScCAKNOG2qCAgAA
X-CMS-MailID: 20191010072810epcas1p1c9d229bd91b0f6734398da90ef55cc2f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191008105726epcas3p178e8421ce5062b6955475199efa130e1
References: <CGME20191008105726epcas3p178e8421ce5062b6955475199efa130e1@epcas3p1.samsung.com>
        <20191008105434.119346-1-stephan@gerhold.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19. 10. 8. 오후 7:54, Stephan Gerhold wrote:
> On some devices (e.g. Samsung Galaxy A5 (2015)), the bootloader
> seems to keep interrupts enabled for SM5502 when booting Linux.
> Changing the cable state (i.e. plugging in a cable) - until the driver
> is loaded - will therefore produce an interrupt that is never read.
> 
> In this situation, the cable state will be stuck forever on the
> initial state because SM5502 stops sending interrupts.
> This can be avoided by clearing those pending interrupts after
> the driver has been loaded.
> 
> Reading the interrupt status registers twice seems to be sufficient
> to make interrupts work in this situation.
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
> This makes interrupts work on the Samsung Galaxy A5 (2015), which
> has recently gained mainline support [1].
> 
> I was not able to find a datasheet for SM5502, so this patch is
> merely based on testing and comparison with the downstream driver [2].
> 
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1329c1ab0730b521e6cd3051c56a2ff3d55f21e6
> [2]: https://protect2.fireeye.com/url?k=029d0042-5ffa4464-029c8b0d-0cc47a31384a-14ac0bce09798d1f&u=https://github.com/msm8916-mainline/android_kernel_qcom_msm8916/blob/SM-A500FU/drivers/misc/sm5502.c#L1566-L1578
> ---
>  drivers/extcon/extcon-sm5502.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/extcon/extcon-sm5502.c b/drivers/extcon/extcon-sm5502.c
> index dc43847ad2b0..c897f1aa4bf5 100644
> --- a/drivers/extcon/extcon-sm5502.c
> +++ b/drivers/extcon/extcon-sm5502.c
> @@ -539,6 +539,12 @@ static void sm5502_init_dev_type(struct sm5502_muic_info *info)
>  			val = info->reg_data[i].val;
>  		regmap_write(info->regmap, info->reg_data[i].reg, val);
>  	}
> +
> +	/* Clear pending interrupts */
> +	regmap_read(info->regmap, SM5502_REG_INT1, &reg_data);
> +	regmap_read(info->regmap, SM5502_REG_INT2, &reg_data);
> +	regmap_read(info->regmap, SM5502_REG_INT1, &reg_data);
> +	regmap_read(info->regmap, SM5502_REG_INT2, &reg_data);

It is not proper. Instead, initialize the SM5502_RET_INT1/2 with zero.

The reset value of SM5502_RET_INT1/2 are zero (0x00) as following:
If you can test it with h/w, please try to test it and then
send the modified patch. 

diff --git a/drivers/extcon/extcon-sm5502.c b/drivers/extcon/extcon-sm5502.c
index c897f1aa4bf5..e168f77a18ba 100644
--- a/drivers/extcon/extcon-sm5502.c
+++ b/drivers/extcon/extcon-sm5502.c
@@ -68,6 +68,14 @@ static struct reg_data sm5502_reg_data[] = {
                .reg = SM5502_REG_CONTROL,
                .val = SM5502_REG_CONTROL_MASK_INT_MASK,
                .invert = false,
+       }, {
+               .reg = SM5502_REG_INT1,
+               .val = SM5502_RET_INT1_MASK,
+               .invert = true,
+       }, {
+               .reg = SM5502_REG_INT2,
+               .val = SM5502_RET_INT1_MASK,
+               .invert = true,
        }, {
                .reg = SM5502_REG_INTMASK1,
                .val = SM5502_REG_INTM1_KP_MASK
diff --git a/drivers/extcon/extcon-sm5502.h b/drivers/extcon/extcon-sm5502.h
index 9dbb634d213b..5c4edb3e7fce 100644
--- a/drivers/extcon/extcon-sm5502.h
+++ b/drivers/extcon/extcon-sm5502.h
@@ -93,6 +93,8 @@ enum sm5502_reg {
 #define SM5502_REG_CONTROL_RAW_DATA_MASK       (0x1 << SM5502_REG_CONTROL_RAW_DATA_SHIFT)
 #define SM5502_REG_CONTROL_SW_OPEN_MASK                (0x1 << SM5502_REG_CONTROL_SW_OPEN_SHIFT)
 
+#define SM5502_RET_INT1_MASK                   (0xff)
+
 #define SM5502_REG_INTM1_ATTACH_SHIFT          0
 #define SM5502_REG_INTM1_DETACH_SHIFT          1
 #define SM5502_REG_INTM1_KP_SHIFT              2

>  }
>  
>  static int sm5022_muic_i2c_probe(struct i2c_client *i2c,
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
