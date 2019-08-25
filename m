Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7B9C3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 20:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66F872080C
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 20:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="merYvVNz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbfHYUpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 16:45:39 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37549 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728909AbfHYUpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 16:45:39 -0400
Received: by mail-lf1-f66.google.com with SMTP id w67so2569236lff.4
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2019 13:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=pYr6d0TqDBZJiGDM65yUDwZgwxV9r/UgERdB1DdKGhk=;
        b=merYvVNz3XTkAguGe0KmeNCT7qATUbpbjfbNSU4cukNfVihROujObBCrwk7sn2iwVo
         k5+KIwUA4W3lNPh0jVDg21qRjZPNk9kx5ngOUawPP5gMBOOIn1mX1TEEl7cO/GElOp4c
         jogPNM/nuYsB7RKcdMX2+pFzMdfghQhfZtOsPV9y0JV/q+j42BExCfa+5ZiRfbHffvc3
         yddfJUsWggXSkwwXQA9pvEZU28HPvt4M2++IghjijaXN7Wjytg+aZYNoXHn4DmrI+dXs
         87KnBt29d58hWsxuHt1gOqvY5qM5hCCjL359z8dT5WO8bNH+cT2N53a2tEZwYdazI+/i
         zOKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=pYr6d0TqDBZJiGDM65yUDwZgwxV9r/UgERdB1DdKGhk=;
        b=Ng0Ihda4XzvtrTmGJpwrWs2Y76CP9n5+495bnwVUBZJRkFhL2rK5fqXJ8UAvbEEDf/
         6AttJKmvh1J7XnFz/gQvR+BfiyCwt1IHJWb3t4klX0Qf/fxgRErAzPWcEkMy65u4sqGV
         RK6U9ka30GjC+q+EK0Jur6s/cg4cBSufflQgNn33XnbjXA2Dh2NVFKlF65cT/AAL3iBZ
         M8eimpHHmfXz+siLjwfRfXvSsApHMJzmM10te8s1b3T/XOQift5z608KlcNVSxHeRhPa
         UyUI6WoYNh6aHph2S/1TO4hbXOavzHw2eK/lRAFXZLmtUKe/y2BjS/8WkxRps+HCudFW
         HTjw==
X-Gm-Message-State: APjAAAXXPM2R3QjEq/LuUmfZik8qjonX9Z8HW85jfzHB2lNdh2SaoAVS
        eguV00JXYzm2Cd3OhaNS11k=
X-Google-Smtp-Source: APXvYqwXNMLWbQhEMkf9Yi0/ZfLM0yayORYGl8XrgkqLZrRcTG+h3OOykWCDwdjHK86g+x6372J1HQ==
X-Received: by 2002:ac2:539b:: with SMTP id g27mr4988676lfh.73.1566765936888;
        Sun, 25 Aug 2019 13:45:36 -0700 (PDT)
Received: from [192.168.0.160] ([178.71.168.190])
        by smtp.gmail.com with ESMTPSA id u20sm1323570lfl.4.2019.08.25.13.45.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Aug 2019 13:45:36 -0700 (PDT)
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Sanjana Sanikommu <sanjana99reddy99@gmail.com>,
        Vatsala Narang <vatsalanarang@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        devel@driverdev.osuosl.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ivan Safonov <insafonov@gmail.com>
From:   Ivan Safonov <insafonov@gmail.com>
Subject: [PATCH] r8188eu: use skb_put_data instead of skb_put/memcpy pair
Message-ID: <4c9e1e66-5ffc-c04b-9ea8-39cec5fd9b2a@gmail.com>
Date:   Sun, 25 Aug 2019 23:48:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

skb_put_data is shorter and clear.

Signed-off-by: Ivan Safonov <insafonov@gmail.com>
---
  drivers/staging/rtl8188eu/core/rtw_recv.c        | 6 +-----
  drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c | 3 +--
  2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_recv.c 
b/drivers/staging/rtl8188eu/core/rtw_recv.c
index 620da6c003d8..d4278361e002 100644
--- a/drivers/staging/rtl8188eu/core/rtw_recv.c
+++ b/drivers/staging/rtl8188eu/core/rtw_recv.c
@@ -1373,11 +1373,7 @@ static struct recv_frame *recvframe_defrag(struct 
adapter *adapter,
                 /* append  to first fragment frame's tail (if privacy 
frame, pull the ICV) */
                 skb_trim(prframe->pkt, prframe->pkt->len - 
prframe->attrib.icv_len);

-               /* memcpy */
-               memcpy(skb_tail_pointer(prframe->pkt), pnfhdr->pkt->data,
-                      pnfhdr->pkt->len);
-
-               skb_put(prframe->pkt, pnfhdr->pkt->len);
+               skb_put_data(prframe->pkt, pnfhdr->pkt->data, 
pnfhdr->pkt->len);

                 prframe->attrib.icv_len = pnfhdr->attrib.icv_len;
                 plist = plist->next;
diff --git a/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c 
b/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c
index eedf2cd831d1..aaab0d577453 100644
--- a/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c
@@ -122,8 +122,7 @@ static int recvbuf2recvframe(struct adapter *adapt, 
struct sk_buff *pskb)
                         precvframe->pkt = pkt_copy;
                         skb_reserve(pkt_copy, 8 - 
((size_t)(pkt_copy->data) & 7));/* force pkt_copy->data at 8-byte 
alignment address */
                         skb_reserve(pkt_copy, shift_sz);/* force ip_hdr 
at 8-byte alignment address according to shift_sz. */
-                       memcpy(pkt_copy->data, (pbuf + 
pattrib->drvinfo_sz + RXDESC_SIZE), skb_len);
-                       skb_put(precvframe->pkt, skb_len);
+                       skb_put_data(pkt_copy, (pbuf + 
pattrib->drvinfo_sz + RXDESC_SIZE), skb_len);
                 } else {
                         DBG_88E("%s: alloc_skb fail , drop frag frame\n",
                                 __func__);
-- 
2.21.0
