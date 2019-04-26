Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 176B7C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 10:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5377206A3
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 10:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qHWweF1X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbfDZKmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 06:42:03 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41586 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfDZKmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 06:42:02 -0400
Received: by mail-lf1-f67.google.com with SMTP id t30so1991267lfd.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 03:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7G6lcwprGm59qtvrGoeGlDhSdzKZT6+L2QiNApFSfd8=;
        b=qHWweF1XKEOokqy0D/+OP4gumBkJBXmwoLKGYN/CjbNpErxYSs4Nna7pta8sVINDGy
         8v07Gxh8H8sxXAoe5qCV/7WDJ5hJbiAPUwDreS3e0JoOrpe+VBPJrmZMU8ihkevayJo7
         Jj2Su6EaAiZ1Ec9SHZ68PgvFYbv+VBcGFQSWSbkDoDYeNLIx+hj9jki5RBhqq+8Fx8d3
         /T7zxrpZX0/QL18uwDPVQptMvFOTfUUBSP3bQikfKh0vV2K0O1tHXVz8s3+NFOf/3yU9
         9LCCWOgdCdejJ5xHirZaRIyFJn4O6mlsOcL82lwO/kK078bKDOfdI52a90NFH4FGtcNG
         HWQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=7G6lcwprGm59qtvrGoeGlDhSdzKZT6+L2QiNApFSfd8=;
        b=rXdDKrdxxVzWUVHl18YKRu2mrtBtUDhH8Kc1eFJL0VA4zA6b6nKcfxiahPl+D6wYnO
         rbOZ30SuwHLuj4tcn4V+OOvXL1dASQNZXJLMZkFA2PV3PpCUfW6E/SK5E2uVFtojonfK
         6OeBt40kAoqdY9F3yG3YJEGS9tUFBYaMmG32Cv7ub50ZZc7xAHj2KlzN3iZ52EvQPaVg
         UiJH7A4B4UhbTjcIkLHSSsb65Royh/I5g202l+wKy5jiGBAOkL1k0w2Ja7tpgIp0bwG9
         Qew4R6/nSmxCHGKT/6FvGsCowE8tm5zYK5btrLeirEe5zoCwzhEhGxZ2hQxq8lI5visy
         srRQ==
X-Gm-Message-State: APjAAAU7ABHAwAMEWPCm3V0ddg6TMHcW7YUE0ZqWPqKz1J2s+0t5uAtB
        urK7IqdzjMtj8QI/NDlNG256LYpbI1A=
X-Google-Smtp-Source: APXvYqyKgmxyzwHrQ4H5sfxW+D3cBMnLxZW0KwIy86DGIaOVCus2cKRqVu3qKADs2zrcnne2qgB6GQ==
X-Received: by 2002:a19:4b51:: with SMTP id y78mr23681328lfa.152.1556275320545;
        Fri, 26 Apr 2019 03:42:00 -0700 (PDT)
Received: from khorivan (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id y206sm6706594lfc.72.2019.04.26.03.41.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 03:42:00 -0700 (PDT)
Date:   Fri, 26 Apr 2019 13:41:57 +0300
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     netdev@vger.kernel.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Jiri Pirko <jiri@resnulli.us>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>,
        Ivan Vecera <ivecera@redhat.com>
Subject: Re: [RFC PATCH v3 net-next 03/11] net: ethernet: ti: cpsw: ale: add
 functions to modify VLANs/MDBs
Message-ID: <20190426104156.GA2796@khorivan>
Mail-Followup-To: Grygorii Strashko <grygorii.strashko@ti.com>,
        netdev@vger.kernel.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Jiri Pirko <jiri@resnulli.us>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>,
        Ivan Vecera <ivecera@redhat.com>
References: <1556144667-27997-1-git-send-email-grygorii.strashko@ti.com>
 <1556144667-27997-4-git-send-email-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1556144667-27997-4-git-send-email-grygorii.strashko@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 01:24:19AM +0300, Grygorii Strashko wrote:
>From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
>A following patch introduces switchdev functionality. Add functions
>to cpsw ALE engine to modify VLANs/MDBs
>
>Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>---
> drivers/net/ethernet/ti/cpsw_ale.c | 179 ++++++++++++++++++++++++++++-
> drivers/net/ethernet/ti/cpsw_ale.h |  10 ++
> 2 files changed, 187 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/net/ethernet/ti/cpsw_ale.c b/drivers/net/ethernet/ti/cpsw_ale.c
>index d09768368dbd..add3f6e4917b 100644
>--- a/drivers/net/ethernet/ti/cpsw_ale.c
>+++ b/drivers/net/ethernet/ti/cpsw_ale.c
>@@ -400,6 +400,45 @@ int cpsw_ale_del_mcast(struct cpsw_ale *ale, const u8 *addr, int port_mask,
> 	return 0;
> }
>
>+static int cpsw_ale_read_mc(struct cpsw_ale *ale, u8 *addr, int flags, u16 vid)
See below.

>+{
>+	u32 ale_entry[ALE_ENTRY_WORDS] = {0, 0, 0};
>+	int idx;
>+
>+	idx = cpsw_ale_match_addr(ale, addr, (flags & ALE_VLAN) ? vid : 0);
>+	if (idx >= 0)
>+		cpsw_ale_read(ale, idx, ale_entry);
>+
>+	return cpsw_ale_get_port_mask(ale_entry, ale->port_mask_bits);
>+}
>+
>+int cpsw_ale_mcast_add_modify(struct cpsw_ale *ale, u8 *addr, int port_mask,
>+			      int flags, u16 vid, int mcast_state)
>+{
>+	int mcast_members, ret;
>+
>+	mcast_members = cpsw_ale_read_mc(ale, addr, flags, vid) | port_mask;
>+	ret = cpsw_ale_add_mcast(ale, addr, mcast_members, flags, vid,
>+				 mcast_state);
By fact, cpsw_ale_add_mcast() is doing modify itself already, just name is
different.

These 3 func duplicate the existent functionality as result code is done twice.
Better remove/combine them and rename existent ones, like:
cpsw_ale_add_mcast() -> cpsw_ale_add_mcast_modify()
cpsw_ale_del_mcast() -> cpsw_ale_del_mcast_modify()

>+
>+	return ret;
>+}
>+
>+int cpsw_ale_mcast_del_modify(struct cpsw_ale *ale, u8 *addr, int port_mask,
>+			      int flags, u16 vid)
See above.

>+{
>+	int mcast_members, ret;
>+	int idx;
>+
>+	mcast_members = cpsw_ale_read_mc(ale, addr, flags, vid) & ~port_mask;
>+	idx = cpsw_ale_match_addr(ale, addr, (flags & ALE_VLAN) ? vid : 0);
>+	if (idx < 0)
>+		return 0;
>+	ret = cpsw_ale_del_mcast(ale, addr, mcast_members, flags, vid);
>+
>+	return ret;
>+}
>+

[...]

-- 
Regards,
Ivan Khoronzhuk
