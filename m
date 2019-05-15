Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E17C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 17:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84F562082E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 17:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQHkwImB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbfEORIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 13:08:53 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43877 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbfEORIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 13:08:53 -0400
Received: by mail-pf1-f194.google.com with SMTP id c6so277317pfa.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 10:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=23X9deLcPS7M5i4nGyMMmygstk5SEYNCAX+o3AHyfeo=;
        b=fQHkwImB8r0QyXlb9e5+h5oXBt5trSiYfkbVVbzlKuBB8URoYIrdk/yKGOurdOlV30
         WkTkhKT0kuQ1GqPmF3oHJqhvKpzyLwZA9y8aVmfoYiHE2s73HSvblddBcoGoBNREOfsH
         P7BNaxeYuIpqHuKWQ3MmfPQZQun2ob/2Gb2ANMHlkL8lIPI0X1Bh/uVurNBdJcBgvB2p
         vhV2/zq0h+FKEHLWvkllwmR7L/RhBi/oCrI02pdDjf9bU0Vt5Ak7vGIissSbfcxuJKue
         7Kq/tGsRGBTIjrBpuGfpGUtlcR8qfJ4iKFDPsJdcue5xVpkX8534WJ1mtki15x6muNVd
         F5yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=23X9deLcPS7M5i4nGyMMmygstk5SEYNCAX+o3AHyfeo=;
        b=lvNLbU959KL5Z0ss0QsTgCfLFTu+XOFYC8FuEwxhiZBQJrzDI9SOz+oUODqytkofgr
         ViNuf+YoE38/sHi/n2+0+2WNIaZhuqPODCUyhySgkv0p4eQ+VFbnKOOpnWghMDJ1hbF5
         LZZOn9x6RpH0ur2fWdMFSuJ30qlP1PyD1sQ6p8d7UeyIDMJyWLqNs7+0sfcZwOwakcDS
         vBX3ESprghd2k+Nn5X7kd+Io3h5aKQdokR/X01EZbX3fgbMRQqFW/CKrzMzlJtJNnku2
         24aQwpsUKULb8fZcWiaKtoaitRDU+9xpSPaJNCiq536NBI9Tc1d+1Ad9i/NFSn/ZXMBG
         2N5w==
X-Gm-Message-State: APjAAAXaTEJBc+ME+YJ2Agc4/zJp8ix6tlbeBI7twzhiO4QAqSwA38l+
        gqqPon9R5k7SQu0BD7Vz1h8=
X-Google-Smtp-Source: APXvYqxvgAGdtqxgTRA3wWjOH/8MQHIh3AOafeFV72Gicxkd3YlsMvnulx4BkFOxuCfcNNlQ9ad67g==
X-Received: by 2002:a62:cdc6:: with SMTP id o189mr22255368pfg.74.1557940132528;
        Wed, 15 May 2019 10:08:52 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.73])
        by smtp.gmail.com with ESMTPSA id b77sm5398936pfj.99.2019.05.15.10.08.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 10:08:51 -0700 (PDT)
Date:   Wed, 15 May 2019 22:38:46 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hardik Singh Rathore <hardiksingh.k@gmail.com>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: core: rtw_recv: fix warning Unneeded
 variable ret
Message-ID: <20190515170846.GA3817@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix below warning reported by coccicheck

drivers/staging/rtl8723bs/core/rtw_recv.c:1903:5-8: Unneeded variable:
"ret". Return "_SUCCESS" on line 1972
drivers/staging/rtl8723bs/core/rtw_recv.c:1618:6-9: Unneeded variable:
"ret". Return "_SUCCESS" on line 1705

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_recv.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index b543e97..b9f758e 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -1615,7 +1615,6 @@ sint wlanhdr_to_ethhdr(union recv_frame *precvframe)
 	u8 *psnap_type;
 	struct ieee80211_snap_hdr	*psnap;
 	__be16 be_tmp;
-	sint ret = _SUCCESS;
 	struct adapter			*adapter = precvframe->u.hdr.adapter;
 	struct mlme_priv *pmlmepriv = &adapter->mlmepriv;
 	u8 *ptr = get_recvframe_data(precvframe) ; /*  point to frame_ctrl field */
@@ -1702,7 +1701,7 @@ sint wlanhdr_to_ethhdr(union recv_frame *precvframe)
 		memcpy(ptr+12, &be_tmp, 2);
 	}
 
-	return ret;
+	return _SUCCESS;
 }
 
 /* perform defrag */
@@ -1900,7 +1899,6 @@ static int amsdu_to_msdu(struct adapter *padapter, union recv_frame *prframe)
 	_pkt *sub_pkt, *subframes[MAX_SUBFRAME_COUNT];
 	struct recv_priv *precvpriv = &padapter->recvpriv;
 	struct __queue *pfree_recv_queue = &(precvpriv->free_recv_queue);
-	int	ret = _SUCCESS;
 
 	nr_subframes = 0;
 
@@ -1969,7 +1967,7 @@ static int amsdu_to_msdu(struct adapter *padapter, union recv_frame *prframe)
 	prframe->u.hdr.len = 0;
 	rtw_free_recvframe(prframe, pfree_recv_queue);/* free this recv_frame */
 
-	return ret;
+	return  _SUCCESS;
 }
 
 int check_indicate_seq(struct recv_reorder_ctrl *preorder_ctrl, u16 seq_num);
-- 
2.7.4

