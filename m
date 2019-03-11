Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA91CC10F06
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8403E2084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=orpaltech.com header.i=@orpaltech.com header.b="YqT3U16g";
	dkim=pass (1024-bit key) header.d=orpaltech.com header.i=@orpaltech.com header.b="YqT3U16g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbfCKSns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:43:48 -0400
Received: from fallback19.mail.ru ([185.5.136.251]:33434 "EHLO
        fallback19.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfCKSns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:43:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=orpaltech.com; s=mailru;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To; bh=gVgVheN27M3lydKtapu2fmsl6ycvYdDRYzuHTqRZDTA=;
        b=YqT3U16gG1zwYyWNW2BBEpXonYXe2Tcuh4Zl8z6V5s5Zs0y9WCOsFdVn5BUHONtchZ5i8TC0fOilKsvPh+VN8AQzRhipFt7UtfxxogIs409C18SCpr8j46ZTWKrs7N8+IwHNQv3PYCwEy+8hOxPDiWQHZ1xa+iT5eSgagfKOz3c=;
Received: from [10.161.100.15] (port=40540 helo=smtpng3.m.smailru.net)
        by fallback19.m.smailru.net with esmtp (envelope-from <ssuloev@orpaltech.com>)
        id 1h3Ptp-0006DA-67
        for linux-kernel@vger.kernel.org; Mon, 11 Mar 2019 21:43:45 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=orpaltech.com; s=mailru;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To; bh=gVgVheN27M3lydKtapu2fmsl6ycvYdDRYzuHTqRZDTA=;
        b=YqT3U16gG1zwYyWNW2BBEpXonYXe2Tcuh4Zl8z6V5s5Zs0y9WCOsFdVn5BUHONtchZ5i8TC0fOilKsvPh+VN8AQzRhipFt7UtfxxogIs409C18SCpr8j46ZTWKrs7N8+IwHNQv3PYCwEy+8hOxPDiWQHZ1xa+iT5eSgagfKOz3c=;
Received: by smtpng3.m.smailru.net with esmtpa (envelope-from <ssuloev@orpaltech.com>)
        id 1h3Pth-0007TV-9Z; Mon, 11 Mar 2019 21:43:37 +0300
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
From:   Sergey Suloev <ssuloev@orpaltech.com>
Subject: sun6i MIPI DSI driver EoTp
Message-ID: <ff953218-219e-7f92-476d-91e2b9904776@orpaltech.com>
Date:   Mon, 11 Mar 2019 21:43:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-77F55803: 6115F4D8777AF1675A78504BD2AC2941B7FF6BDF4DCC2FA7940D59F395E0D3D937C95C6E00B0EEB3466214DA75372F68
X-7FA49CB5: 0D63561A33F958A5F7D5D3FCC46631FC9C7B7201C41FFDD75B6023B3C3134AE98941B15DA834481FA18204E546F3947CEDCF5861DED71B2F389733CBF5DBD5E9C8A9BA7A39EFB7666BA297DBC24807EA117882F44604297287769387670735209ECD01F8117BC8BEA471835C12D1D977C4224003CC836476C0CAF46E325F83A522CA9DD8327EE4930A3850AC1BE2E7352031B8CAF0A05491EE545B711AA744D6731C566533BA786A40A5AABA2AD371193C9F3DD0FB1AF5EBDFC194086D65061027F269C8F02392CD5571747095F342E88FB05168BE4CE3AF
X-Mailru-Sender: 689FA8AB762F739359CD701D0F70D3B1C034263DE54CC43D3680EADCF5A4F111778B5FB1219D8779F6BCD4B1DE95BF653AE5922765F965CDF1D7D1B96E5495AE10FCEA6DFE3E0A150D4ABDE8C577C2ED
X-Mras: OK
X-77F55803: 5241C2F38277A35D7F9F52485CB584D7271FD7DF62800FDCC52C947E43E79B0335FD18A3C2192E060E9EBC906B380A9C4CD37A0B64E33546
X-7FA49CB5: 0D63561A33F958A556A2CF657B836086790AD9F907DD3FF718974E66F091C0F58941B15DA834481FA18204E546F3947CEDCF5861DED71B2F389733CBF5DBD5E9C8A9BA7A39EFB7666BA297DBC24807EA117882F44604297287769387670735209ECD01F8117BC8BEA471835C12D1D977C4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0F8DB212830C5B42F72623479134186CDE6BA297DBC24807EABDAD6C7F3747799A
X-Mailru-Sender: A5480F10D64C90052060E016933BC0398D885A467C77DA1FE6F7044128E069841B4ECFBB0E18FD1430E0C387E5A547B11458020726E2BC9F3DCCAA514539E16D84263029B993B78B51B7A74EF4A1C2D70DA7A0AF5A3A8387
X-Mras: OK
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Maxime,

according to MIPI DSI spec chapter 8.8.2  the EoTp packet can be enabled 
or disabled on the protocol level.
It seems like that it might be required for the panel I am working on 
(Himax HX8379A-based panel).
Here is some crappy driver I found on github showing that it might be an 
issue  [1]

May I ask you if this feature supported by sun6i MIPI DSI driver and 
where ?
As there is no datasheet available, could you please help to support 
this feature (if not yet) ?

The second point is that the panel requires NON-BURST-WITH-SYNC-EVENTS 
mode.
Could it be a problem with the current driver?

[1] 
https://github.com/lnfamous/Kernel_Htc_Pico_CyanogenMod12.1/blob/ff5eed4b86f5c9e653ebde4d89fe969c6abf611a/drivers/video/msm/mipi_hx8379a_video_wvga_pt.c#L107

[2] 
https://github.com/lnfamous/Kernel_Htc_Pico_CyanogenMod12.1/blob/ff5eed4b86f5c9e653ebde4d89fe969c6abf611a/drivers/video/msm/mipi_hx8379a_video_wvga_pt.c#L92

Thank you,
Sergey

