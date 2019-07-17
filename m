Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3253C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 18:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EEF321743
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 18:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cvFuXAwA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388329AbfGQSGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 14:06:42 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38966 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727271AbfGQSGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 14:06:42 -0400
Received: by mail-pg1-f194.google.com with SMTP id u17so11531770pgi.6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 11:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=FYqjCNDgdwxDrTeEvfRkTBRjcpgK1SokFa0ifJO2fuQ=;
        b=cvFuXAwAcLCD0f1dox0053BiwpvnWSpYSnKtgHhKAocIEArOfcO+cUSJh3N/9zBsjN
         8nqyexbg+vCk9ZV+BTWl2Xlgunya2hAYD9o3H+k71dkf8SF3GuOkHVcEO4hCqMFL05It
         rKsF1BIDL48KHiKXcsHt8nWC7duiQfGALK6ONfw8IoppFaHYT90mMElWdsEqB65ZRJgJ
         XWliWxe1/PzZjRjXqythmo1d0NWaS99X4pNOCVufSVtNlxemUILrEQR/F3eW8fQ5hRJ3
         QOpN5F3mA9mBDdOVHE2EO6oltcg+RNzNymW8kB2aCAr9/Co7vLd4Or7mIakEtw3LqDzR
         6Hww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=FYqjCNDgdwxDrTeEvfRkTBRjcpgK1SokFa0ifJO2fuQ=;
        b=GZ5udDU1G1PFOIPbi/BvubKHvl18fgF/i67efh6q+MUx0e0UX4IpJknQcx9xar50R+
         xdlrSoffNAZOPjJ8iprb6K04y5IQHik34oto4YY1UA+aTuEE5xUGyZeJRILmzNT0mYNp
         MwQ7a7Xa2R5Fjb7guPzVmGHY8DU1N23PMkSgtQF8+AG0eT9X1yLPqA30tUBftCiNHEua
         W0Ib5Fz4rj2YYEw2I0SqAmepNcPD/lyJt/PIzG1s+jZL3t4pc+BG1X4k99kR8708JLYp
         IMrae/JZY9eqhj/73Z4EhgYIwSkRutqRVGoADLPjOJL9wFldAhwX2IH5ynoB+LIN3Ktd
         lIPA==
X-Gm-Message-State: APjAAAVbweQVQ5e6PVdWax4m+Og07PIc+oUUxMYmU4+Qf1cmNaTiZqbQ
        HXI//G2Hpfv0F6VSZ1NU410=
X-Google-Smtp-Source: APXvYqwKC9l0ZDIPUfTTO5jWoFOZj3DSuNLxUFv6ftRFtYHflitwxSQ9VhBohEJ6qrbURLjcpPJoGA==
X-Received: by 2002:a63:d34c:: with SMTP id u12mr27655835pgi.114.1563386801044;
        Wed, 17 Jul 2019 11:06:41 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.86.126])
        by smtp.gmail.com with ESMTPSA id j1sm46520337pgl.12.2019.07.17.11.06.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jul 2019 11:06:40 -0700 (PDT)
Date:   Wed, 17 Jul 2019 23:36:35 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vatsala Narang <vatsalanarang@gmail.com>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Emanuel Bennici <benniciemanuel78@gmail.com>,
        Hardik Singh Rathore <hardiksingh.k@gmail.com>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        Michael Straube <straube.linux@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: core: Remove Unneeded variable ret
Message-ID: <20190717180635.GA11412@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove Unneeded variable ret . Return _FAIL .

We cannot change return type of on_action_spct as its callback function.

Issue identified with coccicheck.

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 4285844..0bec806 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -1882,7 +1882,6 @@ unsigned int OnAtim(struct adapter *padapter, union recv_frame *precv_frame)
 
 unsigned int on_action_spct(struct adapter *padapter, union recv_frame *precv_frame)
 {
-	unsigned int ret = _FAIL;
 	struct sta_info *psta = NULL;
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	u8 *pframe = precv_frame->u.hdr.rx_data;
@@ -1914,7 +1913,7 @@ unsigned int on_action_spct(struct adapter *padapter, union recv_frame *precv_fr
 	}
 
 exit:
-	return ret;
+	return _FAIL;
 }
 
 unsigned int OnAction_back(struct adapter *padapter, union recv_frame *precv_frame)
-- 
2.7.4

