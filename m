Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0088C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C356C2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552412347;
	bh=6paLWQNG0L+rvjqLdhQwakz/RbHtyYQt7r3QNOf9TrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k3yBGForSA398oWZ/Ks1jjIi1qMS8bi4i7zFLcOIPLSbx7RYVsfcZC/Jcesrnen6z
	 B8wEqMn+K+rT1XZPITGf+AUpluXvSVke1rDbDo6s1mW5A0VqXxBDcX6aqwO7KrW3hW
	 lSyglMtUvVBH1tX02pnbUe82t4G5iYx1Z1G16pQM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbfCLRQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:16:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:55750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728696AbfCLRPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:15:25 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4561D21741;
        Tue, 12 Mar 2019 17:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410924;
        bh=6paLWQNG0L+rvjqLdhQwakz/RbHtyYQt7r3QNOf9TrI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KoSWmlHEkUzx5XA7+PQzVFM/UW1H5f9xdjuC88Jd15Gg5MLmMAYtR9zCqJxBKYQi7
         1M7CMNz4scGcveBdF7NYQkOEVk3rrx6ny5M9aLzP6l1tos0rjywViSChq7IX2pYOu0
         U65bK6uigViUVuybGt5BmiWZohnu8V4xs5hqdLeA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "Daniel F. Dickinson" <cshored@thecshore.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Christian Lamparter <chunkeey@gmail.com>
Subject: [PATCH 4.19 144/149] ath9k: Avoid OF no-EEPROM quirks without qca,no-eeprom
Date:   Tue, 12 Mar 2019 10:09:22 -0700
Message-Id: <20190312170401.358590286@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170349.421581206@linuxfoundation.org>
References: <20190312170349.421581206@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel F. Dickinson <cshored@thecshore.com>

commit ce938231bd3b1d7af3cbd8836f084801090470e1 upstream.

ath9k_of_init() function[0] was initially written on the assumption that
if someone had an explicit ath9k OF node that "there must be something
wrong, why would someone add an OF node if everything is fine"[1]
(Quoting Martin Blumenstingl <martin.blumenstingl@googlemail.com>)

"it turns out it's not that simple. with your requirements I'm now aware
of two use-cases where the current code in ath9k_of_init() doesn't work
without modifications"[1]

The "your requirements" Martin speaks of is the result of the fact that I
have a device (PowerCloud Systems CR5000) has some kind of default - not
unique mac address - set and requires to set the correct MAC address via
mac-address devicetree property, however:

"some cards come with a physical EEPROM chip [or OTP] so "qca,no-eeprom"
should not be set (your use-case). in this case AH_USE_EEPROM should be
set (which is the default when there is no OF node)"[1]

The other use case is:

the firmware on some PowerMac G5 seems to add a OF node for the ath9k
card automatically. depending on the EEPROM on the card AH_NO_EEP_SWAP
should be unset (which is the default when there is no OF node). see [3]

After this patch to ath9k_of_init() the new behavior will be:

    if there's no OF node then everything is the same as before
    if there's an empty OF node then ath9k will use the hardware EEPROM
      (before ath9k would fail to initialize because no EEPROM data was
      provided by userspace)
    if there's an OF node with only a MAC address then ath9k will use
      the MAC address and the hardware EEPROM (see the case above)
    with "qca,no-eeprom" EEPROM data from userspace will be requested.
      the behavior here will not change
[1]

Martin provides additional background on EEPROM swapping[1].

Thanks to Christian Lamparter <chunkeey@gmail.com> for all his help on
troubleshooting this issue and the basis for this patch.

[0]https://elixir.bootlin.com/linux/v4.20-rc7/source/drivers/net/wireless/ath/ath9k/init.c#L615
[1]https://github.com/openwrt/openwrt/pull/1645#issuecomment-448027058
[2]https://github.com/openwrt/openwrt/pull/1613
[3]https://patchwork.kernel.org/patch/10241731/

Fixes: 138b41253d9c ("ath9k: parse the device configuration from an OF node")
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Daniel F. Dickinson <cshored@thecshore.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Cc: Christian Lamparter <chunkeey@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/ath/ath9k/init.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/net/wireless/ath/ath9k/init.c
+++ b/drivers/net/wireless/ath/ath9k/init.c
@@ -636,15 +636,15 @@ static int ath9k_of_init(struct ath_soft
 		ret = ath9k_eeprom_request(sc, eeprom_name);
 		if (ret)
 			return ret;
+
+		ah->ah_flags &= ~AH_USE_EEPROM;
+		ah->ah_flags |= AH_NO_EEP_SWAP;
 	}
 
 	mac = of_get_mac_address(np);
 	if (mac)
 		ether_addr_copy(common->macaddr, mac);
 
-	ah->ah_flags &= ~AH_USE_EEPROM;
-	ah->ah_flags |= AH_NO_EEP_SWAP;
-
 	return 0;
 }
 


