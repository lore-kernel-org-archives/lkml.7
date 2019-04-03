Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD85AC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AF6D206B8
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YRbXW7b3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfDCPfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 11:35:31 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:46463 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfDCPfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 11:35:30 -0400
Received: by mail-wr1-f49.google.com with SMTP id t17so8949419wrw.13;
        Wed, 03 Apr 2019 08:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yAxJMOE1x3To24t2R0ABLokGVCW7S0c85+BdF2GgpYo=;
        b=YRbXW7b3UDrIcmBVWLMeeISLGT4zKE9q4xrpsuOQmKqLZLFf7g/9DVLXjzC2TdUFuE
         bDSc9BRZht9F5mlWVxzMTJyY5L3wpHcXWruYDSPemHx5FhUK9UJutlMChSEInEPz3MAA
         FtaQ/x3Du99DgFmZSrZPF6bUwDLSyJ4PFlXK0IZKTJYEuOi18RfUcW8ip7dTlNID5lh2
         2iVYtfUtIEJEOyvOROxVaIHIWqUE835UyCGna8uAeCEaYl+xdxvJJ2Zyc7z2fiMxx4Up
         sE8YgjUlzNJeg4loX10hHGA5TOQZBHzfSN6gcqsXyClN5DqKd53O5lR+uyxkh17YxV24
         z5bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yAxJMOE1x3To24t2R0ABLokGVCW7S0c85+BdF2GgpYo=;
        b=YqRYdJqukaRT0L4DaIRto1WUSAD+6CpqrioooIrtmZmdkBae4irXFr6vc+I/icUMm0
         YY6JNJA69Bh3KU9ltCz3cZUk9DKckhSjSUbi7cs+vSfmhdD1oB6zKkA2fW6DnT290e8+
         ILzKPn417OL1uFRaVmlNLbTeCP8rDkHtNCKSl07zHo43OZoyBU/OwXuLF/mFSmsCWqKv
         kWcWYAhE/Edrx8F+zPi/Ei5CMYGfaB9fqWYvt9Lg+JrbPvtpC7LDCJmhMBBLwi6chHmd
         X/HlvPCxP2FnfzBUh/NPkD3ucqWlRyprh2rvvGb+K7l2aK/mSAV6Vam5T01ZEbWGXBOc
         X5iA==
X-Gm-Message-State: APjAAAUmmkogRERJK+3HBJtoeG6gZSf59CzcjJRLX3ae92AXJwLyn0hx
        18KfnqB6p568ZtPSfVPMQNE=
X-Google-Smtp-Source: APXvYqz3JM5FO9pe7qTmq1bmbom6/QelC3GGtfaxVE3/aLZwPUlOp8fHV/AuXmwl/d/p3KN1QT/vPA==
X-Received: by 2002:adf:e951:: with SMTP id m17mr87551wrn.287.1554305729287;
        Wed, 03 Apr 2019 08:35:29 -0700 (PDT)
Received: from X555LD ([2a02:85f:510:b900:d5bf:dcd8:8640:a2fe])
        by smtp.gmail.com with ESMTPSA id l12sm21808368wrt.31.2019.04.03.08.35.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Apr 2019 08:35:28 -0700 (PDT)
Date:   Wed, 03 Apr 2019 18:35:21 +0300
From:   "Leonidas P. Papadakos" <papadakospan@gmail.com>
Subject: RE: [PATCH 1/2] stmmac: introduce flag to dynamically disable TX
 offload for rockchip devices
To:     Jose Abreu <jose.abreu@synopsys.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Heiko =?iso-8859-1?q?St=FCbner?= <heiko@sntech.de>,
        Christoph =?iso-8859-1?q?M=FCllner?= 
        <christoph.muellner@theobroma-systems.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Klaus Goger <klaus.goger@theobroma-systems.com>
Message-Id: <1554305721.1328.0@gmail.com>
In-Reply-To: <78EB27739596EE489E55E81C33FEC33A0B4254A0@de02wembxa.internal.synopsys.com>
References: <20190401181840.31255-1-papadakospan@gmail.com>
        <9d65a22a-2288-dc53-0059-ec4a31424dd8@arm.com> <2312344.mOsv7YkeBG@diego>
        <9EC67532-2D43-4AAD-BFA7-8B6797067427@theobroma-systems.com>
        <78EB27739596EE489E55E81C33FEC33A0B421348@de02wembxa.internal.synopsys.com>
        <4a9839d6-3d90-4354-7b64-78d5c1126e99@arm.com>
        <78EB27739596EE489E55E81C33FEC33A0B423811@de02wembxa.internal.synopsys.com>
        <c45d05f1-47b0-89d5-886d-d456d0111b7a@arm.com> <1554245296.1271.0@gmail.com>
        <78EB27739596EE489E55E81C33FEC33A0B4254A0@de02wembxa.internal.synopsys.com>
X-Mailer: geary/3.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



=CE=A3=CF=84=CE=B9=CF=82 =CE=A4=CE=B5=CF=84, 3 =CE=91=CF=80=CF=81, 2019 at =
10:55 =CE=A0=CE=9C, =CE=BF/=CE=B7 Jose Abreu=20
<jose.abreu@synopsys.com> =CE=AD=CE=B3=CF=81=CE=B1=CF=88=CE=B5:
> From: Leonidas P. Papadakos <papadakospan@gmail.com>
> Date: Tue, Apr 02, 2019 at 23:48:16
>=20
>>  I can confirm that snps,no-pbl-x8, currently set by uboot for the=20
>> fdt
>>  basically fixes the tx-checksumming issue.
>>  I get 700~800 Mbps myself but that might come down to the setup.
>>  You could say it affects performance slightly, as I saw in a=20
>> previous
>>  email.
>>=20
>>  Without the setting The rate consistently drops to 0.
>>  ethtool reports tx-checksumming is on in both cases
>>=20
>>  Pretty cool!
>>  Does that give you guys an idea on how to tackle it "officially"?
>>=20
>>=20
>>=20
>=20
> Thank you all for testing !
>=20
> It's been on my todo list to cook up a patch that limits PBL=20
> according to
> FIFO size but I didn't manage to have the time yet so for now it would
> be better if you fix it by submitting the DT bindings changes.
>=20
> Thanks,
> Jose Miguel Abreu

If snps,no-pbl-x8 does indeed have a performace hit, should the=20
workaround be to
a) turn tx checksumming off or
b) snps,no-pbl-x8 set?

I'll test to see the difference

=

