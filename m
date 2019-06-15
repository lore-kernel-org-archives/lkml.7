Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26282C31E47
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 04:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE87221773
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 04:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTqzxIcQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbfFOEhD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Jun 2019 00:37:03 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33042 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbfFOEhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 00:37:02 -0400
Received: by mail-pg1-f196.google.com with SMTP id k187so2665230pga.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 21:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=q2r6AD+gcy9pQMyOS5hD54vNjbTsuyd4RCExb0fM2pY=;
        b=CTqzxIcQNSQePrhTuYqnWRyrJ3m7Y/n/1ylOQ3QfTCb0/ah4nKQiLgbJ213qp5K/dk
         CxPqQtEhgs6WJsuqkXI5BYZuNcfQbyOp5dFrpMjLFlCO+vwX6uahNpSPaal1KEnH06KP
         03/2CllAoAnh9p66fCzCDDqBpYXkrWfMo6EYl5sSBRsBO8CBK6VOVmp05nrBEmwkAfsl
         WzUie4JQkZk8m3XYUpivkojVwfV7bJOjcbxWVmQ9SsQww/thllTsK9esN/kgnxUf0Wd4
         +QU1THQRcU2odjYFrIgoj3gEfAS27Sax4NtO+bVdnqsSp8iBvAXI8yrPhmTnEkFwyBL+
         /s4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=q2r6AD+gcy9pQMyOS5hD54vNjbTsuyd4RCExb0fM2pY=;
        b=IbYQgI/vTFeG5OlNEiMZ+keVhB0tzPauOSHe7BtfZjnbbk2Adrh8eyfRIjIEU2faNx
         qZopWUiiDx4YabAZmB/UAbsjBGCi1J5UJX5uiP0bXhk71pCqEeSz34vCSmvrv9Ib3RVb
         Q+pKUlPgHP+nRrEecWu8AwSM7ls+s9haf/+135peqRVZbNMpwYyRdhVlQVCgId+mDP08
         kxQhdPp0QTCcSLqEeeFltGDqP2BgPizT+fHXd3w1sqg8JapmFtD3jBrMdcg1nw267gZk
         sWD3FBf3UBP/Rk/62ndach8Vd3DG6f7Do0u2KjvxibQCZKDmNgyQZ6+oHgdiggahLFZ7
         pzLQ==
X-Gm-Message-State: APjAAAV3atTwLPvmpXskoxFv6IJ6uArdJU3eXPq46ls9tgq/gfQzKZK5
        UrXs4iI2o1s30WfgDNyv4qA=
X-Google-Smtp-Source: APXvYqyqCLmnIvcGNvq4D9wJ4Ihu8wbmegQPVDYYNqCRFdPAClO5REXkPgECJcB9/VkQUlQxYgxVNw==
X-Received: by 2002:a17:90a:de0e:: with SMTP id m14mr14514409pjv.36.1560573421918;
        Fri, 14 Jun 2019 21:37:01 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.89.153])
        by smtp.gmail.com with ESMTPSA id g19sm4918933pgb.26.2019.06.14.21.36.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 21:37:01 -0700 (PDT)
Date:   Sat, 15 Jun 2019 10:06:57 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Himadri Pandya <himadri18.07@gmail.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] staging: rtl8723bs: hal: spaces preferred around unary
 operator
Message-ID: <20190615043657.GA12626@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes below issues reported by checkpatch

CHECK: spaces preferred around that '-' (ctx:VxV)
CHECK: spaces preferred around that '/' (ctx:VxV)

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c b/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
index 215335c..b44e902 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
@@ -284,7 +284,7 @@ static s32 xmit_xmitframes(struct adapter *padapter, struct xmit_priv *pxmitpriv
 				txlen = txdesc_size + rtw_wlan_pkt_size(pxmitframe);
 				if(	!pxmitbuf ||
 					((_RND(pxmitbuf->len, 8) + txlen) > max_xmit_len) ||
-					(k >= (rtw_hal_sdio_max_txoqt_free_space(padapter)-1))
+					(k >= (rtw_hal_sdio_max_txoqt_free_space(padapter) - 1))
 				) {
 					if (pxmitbuf) {
 						/* pxmitbuf->priv_data will be NULL, and will crash here */
@@ -355,8 +355,8 @@ static s32 xmit_xmitframes(struct adapter *padapter, struct xmit_priv *pxmitpriv
 					rtw_count_tx_stats(padapter, pxmitframe, pxmitframe->attrib.last_txcmdsz);
 
 					txlen = txdesc_size + pxmitframe->attrib.last_txcmdsz;
-					pxmitframe->pg_num = (txlen + 127)/128;
-					pxmitbuf->pg_num += (txlen + 127)/128;
+					pxmitframe->pg_num = (txlen + 127) / 128;
+					pxmitbuf->pg_num += (txlen + 127) / 128;
 				    /* if (k != 1) */
 					/* 	((struct xmit_frame*)pxmitbuf->priv_data)->pg_num += pxmitframe->pg_num; */
 					pxmitbuf->ptail += _RND(txlen, 8); /*  round to 8 bytes alignment */
@@ -522,7 +522,7 @@ s32 rtl8723bs_mgnt_xmit(
 	rtl8723b_update_txdesc(pmgntframe, pmgntframe->buf_addr);
 
 	pxmitbuf->len = txdesc_size + pattrib->last_txcmdsz;
-	pxmitbuf->pg_num = (pxmitbuf->len + 127)/128; /*  128 is tx page size */
+	pxmitbuf->pg_num = (pxmitbuf->len + 127) / 128; /*  128 is tx page size */
 	pxmitbuf->ptail = pmgntframe->buf_addr + pxmitbuf->len;
 	pxmitbuf->ff_hwaddr = rtw_get_ff_hwaddr(pmgntframe);
 
-- 
2.7.4

