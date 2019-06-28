Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE45EC5B579
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 18:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBE61214DA
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 18:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="umHm/BsC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbfF1Ssh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 14:48:37 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:37241 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbfF1Ssh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 14:48:37 -0400
Received: by mail-yb1-f195.google.com with SMTP id l22so3779737ybf.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 11:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v0P1Y//StJz44s7/YZiM+cINw7p7Yh+9CFilXpnVTxQ=;
        b=umHm/BsCRb8IzduSRjjF+2RoYF9GucD8xkNXBcbbtkmIFwersM/sM+9MWaQrSorKt2
         TmbhY632T7iPUsDNZT85rUaoZ6+kVrTQXbhd+oD7ZIZcHIhniC501Yq4oDdSiU/04hYm
         ZEdG7pq/ftop4ayY52UuIsE5WXcEOzWraSc7zeUUxR4ViI4SO8OtnYTEDOoMxWFVsvES
         +C7BjToBRpkZp/ldCK2Dssv0ZtrGQM3MI0X79m+rk6W5n3dR+tXM5xjzEnLAFFpxaJEu
         1DG/DiHQr6xOfzvEFw144KvpRuIr4XtKUCcem4dhqcxAf2jwxMmLsLVasHUuuaQyqD3T
         PqUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v0P1Y//StJz44s7/YZiM+cINw7p7Yh+9CFilXpnVTxQ=;
        b=qm/HN2jKHC42tkJqrTk8h/Dmn98Xh9cK4Z5q0fFxK0UR5f0yMLzP8lZn2PW7uGSCPM
         yYbzd0AxkaCz3SBnEslQZXE1BRcZyumLXTX8h6ZgsruzlRmnRz4KP4BPqNnGO4gzbI4R
         HKxYuR55/uNiiDTN8aSwyG5q1/uTp3t8b91YnnZK05y0MfQL0XgRC1SdCld0dbu8BC1x
         Ln6xZoXPFy9kdgez+xg6c5MZ637AQZsH2zBBcMhUp2C47d8TnAmssd239G4QeKy2vYlO
         Z9CE0+vwg3WYUhLED/bvXB6vmdEBk1kUJVIDKblBDQ+F3MIm2WtBG0ZOL8BCm6wC2yoF
         GMDQ==
X-Gm-Message-State: APjAAAW0XAwzWvSZO/18JZckgcXo01MWPr38kO4eZjqcpVFpHTXp0kZr
        TsBJZluM4P/2cQi+LT3Dhqm8k0xf
X-Google-Smtp-Source: APXvYqwGKzqHuvhfSwF+7rEIHyOsQwU6IO8y5aWYSOZoxksbzFX7jgxX7Iw3VNMYqldeB1+QqM0SKQ==
X-Received: by 2002:a25:b317:: with SMTP id l23mr7516231ybj.17.1561747715111;
        Fri, 28 Jun 2019 11:48:35 -0700 (PDT)
Received: from mail-yw1-f52.google.com (mail-yw1-f52.google.com. [209.85.161.52])
        by smtp.gmail.com with ESMTPSA id 200sm725505ywq.102.2019.06.28.11.48.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 11:48:34 -0700 (PDT)
Received: by mail-yw1-f52.google.com with SMTP id d204so1165732ywb.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 11:48:33 -0700 (PDT)
X-Received: by 2002:a81:4d86:: with SMTP id a128mr7047569ywb.291.1561747713444;
 Fri, 28 Jun 2019 11:48:33 -0700 (PDT)
MIME-Version: 1.0
References: <1561722618-12168-1-git-send-email-tanhuazhong@huawei.com> <1561722618-12168-3-git-send-email-tanhuazhong@huawei.com>
In-Reply-To: <1561722618-12168-3-git-send-email-tanhuazhong@huawei.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Fri, 28 Jun 2019 14:47:57 -0400
X-Gmail-Original-Message-ID: <CA+FuTSdWa0dMz15m79SLsNAw9zkp3+3MSfKiRwKnjZ7QAyq1Uw@mail.gmail.com>
Message-ID: <CA+FuTSdWa0dMz15m79SLsNAw9zkp3+3MSfKiRwKnjZ7QAyq1Uw@mail.gmail.com>
Subject: Re: [PATCH net-next 02/12] net: hns3: enable DCB when TC num is one
 and pfc_en is non-zero
To:     Huazhong Tan <tanhuazhong@huawei.com>
Cc:     David Miller <davem@davemloft.net>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        salil.mehta@huawei.com, yisen.zhuang@huawei.com,
        linuxarm@huawei.com, Yunsheng Lin <linyunsheng@huawei.com>,
        Peng Li <lipeng321@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 7:53 AM Huazhong Tan <tanhuazhong@huawei.com> wrote:
>
> From: Yunsheng Lin <linyunsheng@huawei.com>
>
> Currently when TC num is one, the DCB will be disabled no matter if
> pfc_en is non-zero or not.
>
> This patch enables the DCB if pfc_en is non-zero, even when TC num
> is one.
>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> Signed-off-by: Peng Li <lipeng321@huawei.com>
> Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>

> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
> index 9edae5f..cb2fb5a 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
> @@ -597,8 +597,10 @@ static void hclge_tm_tc_info_init(struct hclge_dev *hdev)
>                 hdev->tm_info.prio_tc[i] =
>                         (i >= hdev->tm_info.num_tc) ? 0 : i;
>
> -       /* DCB is enabled if we have more than 1 TC */
> -       if (hdev->tm_info.num_tc > 1)
> +       /* DCB is enabled if we have more than 1 TC or pfc_en is
> +        * non-zero.
> +        */
> +       if (hdev->tm_info.num_tc > 1 || hdev->tm_info.pfc_en)

small nit: comments that just repeat the condition are not very informative.

More helpful might be to explain why the DCB should be enabled in both
these cases. Though such detailed comments, if useful, are better left
to the commit message usually.

>                 hdev->flag |= HCLGE_FLAG_DCB_ENABLE;
>         else
>                 hdev->flag &= ~HCLGE_FLAG_DCB_ENABLE;
> @@ -1388,6 +1390,19 @@ void hclge_tm_schd_info_update(struct hclge_dev *hdev, u8 num_tc)
>         hclge_tm_schd_info_init(hdev);
>  }
>
> +void hclge_tm_pfc_info_update(struct hclge_dev *hdev)
> +{
> +       /* DCB is enabled if we have more than 1 TC or pfc_en is
> +        * non-zero.
> +        */
> +       if (hdev->tm_info.num_tc > 1 || hdev->tm_info.pfc_en)
> +               hdev->flag |= HCLGE_FLAG_DCB_ENABLE;
> +       else
> +               hdev->flag &= ~HCLGE_FLAG_DCB_ENABLE;
> +
> +       hclge_pfc_info_init(hdev);
> +}

Avoid introducing this code duplication by defining a helper?
