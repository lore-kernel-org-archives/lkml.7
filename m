Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0367AC31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 01:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9EFE2082C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 01:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGDCbsFD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbfFRBqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 21:46:09 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45557 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfFRBqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 21:46:08 -0400
Received: by mail-ed1-f68.google.com with SMTP id a14so19010476edv.12;
        Mon, 17 Jun 2019 18:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=hCsjQGiJ/7GDnkV2qpxf/QtLQthLwVtSs+DYwUa5jk8=;
        b=HGDCbsFDI7LLKV3hHB3E1XrST8R8KCEkFk2FIomgo6oUnOkB8cq0vup6ospX8dwhAW
         3ZTGKRbGX3E/DnrwXH/dUTSCxMkt+WBNIZ1vQ0bE7qdMbScLb7kGBewe58duFb7Gfj69
         LznJy34U0P2h44aiQ1DxD/vb1KwVbffGqEc6Sl+51QWxZvQqoMIh27sBhbhRfYRM4ADO
         22k0E8xOSvarx45kknuRLsAydvjvU5kpUIubzYpALdSZh8ufIPBdesCg0g1I63mt8AQu
         5L0f90WGMcDLJ1OKzSxiDmbKJ+FYMntw7OZSBj/YZIFRaATPssP3hwZfHWSzebKoLUoM
         zqyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=hCsjQGiJ/7GDnkV2qpxf/QtLQthLwVtSs+DYwUa5jk8=;
        b=l0/X35ORcBIErbDcGBHKrk8hkDdqG1JalfbZu5Fj+KUcFAM6MpZcToSFnHuNTURhq9
         Cnx4g4VbywI2gYpBiiwcN8uNQXkjdmdf+pyJGkp0VFZIbkiBojvQGS7mRbnekA/TP9Z6
         O75hks9CfgtwgWGu+jpHY2H3Ip9l5am2VFDafGgymwAh+xHMx6EMPq0govTUdc8yfA4C
         JtptQVEAZX0V9p4vo0YqkucZDmeNn4EGfP2IqXHF4l2qvqkFmlYCpUuPbZuXoemTR6WT
         By2EKdW4KxQiQmD4t2zYjanhmXb6bEuTfTmptYONWdHj8KOGlCZS+WWS0v3Ihtb4UQkc
         l+7Q==
X-Gm-Message-State: APjAAAU3+9H7MIvk+As1KRjSR9nYVL2feZfHPiF+kupHryivrOAGLTGy
        MLydoT316tF1I/66Qyi8GlM=
X-Google-Smtp-Source: APXvYqyBmn6jjXjEvQ0g9uSunUAKnSmOBPkqp8jGMObGmSFfQYREM6TYXHsk0qz8+CWWF/gHFAdZpA==
X-Received: by 2002:a50:fb0a:: with SMTP id d10mr41206347edq.124.1560822366854;
        Mon, 17 Jun 2019 18:46:06 -0700 (PDT)
Received: from archlinux-epyc ([2a01:4f9:2b:2b15::2])
        by smtp.gmail.com with ESMTPSA id m31sm4306805edd.42.2019.06.17.18.46.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 18:46:06 -0700 (PDT)
Date:   Mon, 17 Jun 2019 18:46:04 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Shalom Toledo <shalomt@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>
Cc:     Petr Machata <petrm@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: arm32 build failure after 992aa864dca068554802a65a467a2640985cc213
Message-ID: <20190618014604.GA17174@archlinux-epyc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

A 32-bit ARM allyesconfig fails to link after commit 992aa864dca0
("mlxsw: spectrum_ptp: Add implementation for physical hardware clock
operations") because of 64-bit division:

arm-linux-gnueabi-ld:
drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.o: in function
`mlxsw_sp1_ptp_phc_settime':
spectrum_ptp.c:(.text+0x39c): undefined reference to `__aeabi_uldivmod'

The following diff fixes it but I have no idea if it is proper or not
(hence reaching out before sending it, in case one of you has a more
proper idea).

Cheers,
Nathan

---

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c
index 2a9bbc90225e..65686f0b6834 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c
@@ -87,7 +87,7 @@ mlxsw_sp1_ptp_phc_settime(struct mlxsw_sp_ptp_clock *clock, u64 nsec)
        u32 next_sec;
        int err;
 
-       next_sec = nsec / NSEC_PER_SEC + 1;
+       next_sec = (u32)div64_u64(nsec, NSEC_PER_SEC + 1);
        next_sec_in_nsec = next_sec * NSEC_PER_SEC;
 
        spin_lock(&clock->lock);


