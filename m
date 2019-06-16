Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A88C31E51
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 03:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0C87216C8
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 03:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJq9+4xU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfFPDfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Jun 2019 23:35:34 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41422 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbfFPDfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 23:35:34 -0400
Received: by mail-pf1-f193.google.com with SMTP id m30so3756213pff.8
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2019 20:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=P+dZfWhhczsv5TTRUbrSlNE3547rfcjOFelTNKUKczI=;
        b=SJq9+4xUablqDSXRTAq0ercysLl4BrTt8Wr2v4V+ZitlX+vGwokkg1PBXq28Ib7C3F
         7jpzuvr2lhhWoruFFoSOKhrw08dLdumrTA0bEkKkIqRHT/OMx7bPHi2X40UryG+12fVM
         1O4CSlDx/MNDO0QZVaKHz0h17gc/NwMgvJF43I8bu3GWv3kxpcGUjM4f64Uv3uIrdnew
         5O9iao2Yi7etmG3zEYgrdLkyY2hlvodEQ1BRgUyxf4bR86kGSgYuWv0g1XlSX9wUTsVW
         5Afxt2Js165Qgx6FPJS2CW1Tb8k30p6bdklfqZ9iEnrYfcOU7ATHqkFcDg/XiG1HONnz
         zDdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=P+dZfWhhczsv5TTRUbrSlNE3547rfcjOFelTNKUKczI=;
        b=ND63oJB5Rlmb3RpQkTN78mAUvx+KlkDzRUq/txxY5kYevT71P2n3wonp0+Ss73WXmp
         l/94yXIV+ZvEfc9QLa21gaAQ1HvTD5Ys2ZbCCl09CQzosgOGyJiF39A3P3lfixjxVPwp
         16A8nWH7TWmEnr7xz0CI+7JWbQn2DE9KIyFKNLM3GiBOCpi0JhwhnILejMbtBpoVinqu
         4YKnA77HgNguH6SiPoRgW4uT3lsdEGimQ4GUPYjDFUfi+qSiJDrsYJNv/DLcxw35fWFV
         UMI9FewvZkUKAj2+oFTJJCaaSwLRSixeyXn2UaXgGQ4y+k5Y4+Xb2iVdCN+LyNDcdaht
         L+mw==
X-Gm-Message-State: APjAAAWP0jGXhrKsy3G5TN2QtvUlfDhPvk683byRghX6/XPrgcsEdSp3
        pUA9o3BsU5lTPt2zgOpKKVo=
X-Google-Smtp-Source: APXvYqy4PejcM3KwVGxdZDCvOpg1et1o372+G1zs9MV0Ol4tYlbZHMG7CMmACiAtZO+Q/XdE/S7bww==
X-Received: by 2002:a17:90a:480d:: with SMTP id a13mr18548872pjh.40.1560656133623;
        Sat, 15 Jun 2019 20:35:33 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.89.153])
        by smtp.gmail.com with ESMTPSA id g6sm7318314pgh.64.2019.06.15.20.35.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Jun 2019 20:35:32 -0700 (PDT)
Date:   Sun, 16 Jun 2019 09:05:27 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Kimberly Brown <kimbrownkd@gmail.com>,
        Shobhit Kukreti <shobhitkukreti@gmail.com>,
        Bastien Nocera <hadess@hadess.net>,
        Anirudh Rayabharam <anirudh.rayabharam@gmail.com>,
        Nishka Dasgupta <nishka.dasgupta@yahoo.com>,
        Hardik Singh Rathore <hardiksingh.k@gmail.com>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging/rtl8723bs/core/rtw_ap: Remove redundant call to
 memset
Message-ID: <20190616033527.GA14062@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtw_zmalloc is internally doing memset . So there is no need to call memset
again.

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index 87b201a..df055b8 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -1502,8 +1502,6 @@ static int rtw_ap_set_key(
 		goto exit;
 	}
 
-	memset(psetkeyparm, 0, sizeof(struct setkey_parm));
-
 	psetkeyparm->keyid = (u8)keyid;
 	if (is_wep_enc(alg))
 		padapter->securitypriv.key_mask |= BIT(psetkeyparm->keyid);
-- 
2.7.4

