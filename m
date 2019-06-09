Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A1C9C468BD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 12:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63A7C212F5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 12:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oin1Rpl1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbfFIMua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 08:50:30 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43274 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728319AbfFIMua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 08:50:30 -0400
Received: by mail-pf1-f195.google.com with SMTP id i189so3708510pfg.10
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2019 05:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=T5uT3cnHIyOhpdeq81GHrT25lmc9BY1BnvaqYtZbkNU=;
        b=Oin1Rpl1FkG6enOWjr2FCLw3CaZCmMpI1FjhO74RP0K0L8rBaAImloF3IZ4j8w4FEP
         MBq5b+JLYGwI2BenQC20tB5IN8uzapQzP8LJ031fzLRiSHQvwxIdEmoFeTG3lNRrQ31i
         ujL+OzGFpH11AAB1p3ruqABcgmECI1QDJ/gWe1z/By7M2Zi4gCP2zHWu33coDuyitDpo
         hJqzfdKEmC0WXLRjdz0taZHF4XHZiTs0oieRgsxp4x8sc1i/Nb2lyw6pdFlbXRc6UKtu
         4cmaEuDLCmqRCxGA1IvbpxknSGZN2t0BIwAItYvzusQ4XHiIh3Eh8U5Es+cdUhOkEq02
         AZnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=T5uT3cnHIyOhpdeq81GHrT25lmc9BY1BnvaqYtZbkNU=;
        b=We6e2gBjeRvSfwJpg6nz/CQ0EU/+TwCafdsid0v3BDrIvYOIF06kzjlkXgjP+VRbQ9
         r7cmQTswJBc4FYD1hzcGWEyRwdQD8q0e8WBR4CGDLaRkNJtRjltLkOfLBDBekz0A5Y66
         yqLFmEM+vaXW1NrrjIs9hmGYGs9kajVt8DhVvjXQGhSmUPy06cNPnEDjYdWc4fDc/lW9
         bkIYNkBwaltAJ+oausrR3tZPMiKSa+mmQTrCehSJH0yNDjgfCho1QiA+mTemQfRjyBU6
         iQNZSlEOQ78mNWjkiEKNgjXAugM5Mr8v8aBT6SlTDS4A6Z7ti5qNljqkQcbWwsKWT8AK
         e7pA==
X-Gm-Message-State: APjAAAXlmwGToC/s1eh161JLM5t+nQ4HjhFU+gwKzLy4LZDOfeVaLXtG
        4DtkH+NfQFEKVzy9Z5E5vhA=
X-Google-Smtp-Source: APXvYqxATSJZ1AbEWy9Yek5EDDUL0mcuATTKFKEvaeH3qS7QfYNS8u3aNwALA03o7jlCw26VyjAU2Q==
X-Received: by 2002:a63:514:: with SMTP id 20mr11296213pgf.272.1560084629346;
        Sun, 09 Jun 2019 05:50:29 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.89.153])
        by smtp.gmail.com with ESMTPSA id n32sm7297159pji.29.2019.06.09.05.50.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Jun 2019 05:50:28 -0700 (PDT)
Date:   Sun, 9 Jun 2019 18:20:24 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Michael Straube <straube.linux@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] staging: rtl8723bs: provide spaces around unary operators
Message-ID: <20190609125024.GA4092@hari-Inspiron-1545>
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
+               skb_copy_bits(pfile->pkt, pfile->buf_len-pfile->pkt_len,
rmem, len);

CHECK: spaces preferred around that '*' (ctx:VxV)
+#define WMM_XMIT_THRESHOLD     (NR_XMITFRAME*2/5)
                                             ^

CHECK: spaces preferred around that '/' (ctx:VxV)
+#define WMM_XMIT_THRESHOLD     (NR_XMITFRAME*2/5)
                                               ^
CHECK: spaces preferred around that '/' (ctx:VxV)
+               if (pxmitpriv->free_xmitframe_cnt > (NR_XMITFRAME/4)) {
                                                                 ^

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/xmit_linux.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/xmit_linux.c b/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
index 4da5617..4e81bc1 100644
--- a/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
@@ -32,7 +32,7 @@ uint _rtw_pktfile_read (struct pkt_file *pfile, u8 *rmem, uint rlen)
 	len = (rlen > len) ? len : rlen;
 
 	if (rmem)
-		skb_copy_bits(pfile->pkt, pfile->buf_len-pfile->pkt_len, rmem, len);
+		skb_copy_bits(pfile->pkt, pfile->buf_len - pfile->pkt_len, rmem, len);
 
 	pfile->cur_addr += len;
 	pfile->pkt_len -= len;
@@ -65,7 +65,7 @@ void rtw_os_xmit_resource_free(struct adapter *padapter, struct xmit_buf *pxmitb
 		kfree(pxmitbuf->pallocated_buf);
 }
 
-#define WMM_XMIT_THRESHOLD	(NR_XMITFRAME*2/5)
+#define WMM_XMIT_THRESHOLD	(NR_XMITFRAME * 2 / 5)
 
 void rtw_os_pkt_complete(struct adapter *padapter, _pkt *pkt)
 {
@@ -229,7 +229,7 @@ int _rtw_xmit_entry(_pkt *pkt, _nic_hdl pnetdev)
 			#endif
 			)
 		&& padapter->registrypriv.wifi_spec == 0) {
-		if (pxmitpriv->free_xmitframe_cnt > (NR_XMITFRAME/4)) {
+		if (pxmitpriv->free_xmitframe_cnt > (NR_XMITFRAME / 4)) {
 			res = rtw_mlcst2unicst(padapter, pkt);
 			if (res)
 				goto exit;
-- 
2.7.4

