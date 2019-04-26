Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 994ADC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 10:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 660BF206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 10:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FztyFW/z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbfDZKxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 06:53:47 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33589 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbfDZKxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 06:53:46 -0400
Received: by mail-wr1-f67.google.com with SMTP id s18so3886639wrp.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 03:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zTcRffH+OP25VLBj/71rHSWXaB0aejUmWK4Jls7WRp0=;
        b=FztyFW/zQzlWc6KBY/Mj3dm4YzjbHfyb+uAd06e03Rw8HcBc6Z40Q4FZd70arwvLyS
         D2e/92UQkPqhR3Rvex6w0MdmfzWhvXyFDeWbLILBTDmy7PHL+qBmf4ohMeOhwjMIqEfX
         3CZG3nO9kjZJFcY5lIqvDPAdsNBdCHhbNVnYXq+PUojlOrIXd9NiuZrUpdU7NR7xBG5K
         +LMDCa2960xeGhmFWqamvioHJWiumXrMwyg9yM5I0xzBoIGoAaMtvjVOsfVqJwnj4Mrf
         LJsnrHbihD9XzY5LANzkAKg/HyV3k5LQcCpOkGRf/2eRFEviXs6C95994Kk7EVlycs7/
         qBkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zTcRffH+OP25VLBj/71rHSWXaB0aejUmWK4Jls7WRp0=;
        b=JJlsxjyjJyBx094g+qG8nB/zEd4o4iLotCQavzARMNzu7TWTG1hcQ9csl3hBi+PpFi
         Rnesy87c/Uo9WMqc0ohjw5leVn5pOInFa3OSeR48ye6IHFXVUCRVNYSon8TOtPqyGf6v
         zQPyGZlDX6cQBiOz4bnjrhhx51BlI/i5p2smnot+l9afwTLaVKWSP7/1lJVeaFhH0ZIq
         aP9vpTYVrSB8rDCDRnAZ5vGA2MGMaiXcKo4pKgp0PwXFI862UQchwH58YV3hLr4U4a0q
         QrHZ3q/G5hI4jxi35XQ1CCDSzGMTGhkKsNPkrmhQrUVgohU7XzEkwuXnkW4A32caRQln
         VTHw==
X-Gm-Message-State: APjAAAXvW1DGZlQcAldYU0CX51g8oHk0qbnlPVGQlTn8m7RlWTt3K56Z
        sZ3V6YPYhSoRwfiDRjr87ipSKw==
X-Google-Smtp-Source: APXvYqxElEL8y25CqmBsoORNTlRTBgdCUoXSFlCRqcjK82BkRlsKqvPa9diiWN541VJLtR6RyBC3tw==
X-Received: by 2002:a5d:484d:: with SMTP id n13mr6979159wrs.219.1556276024829;
        Fri, 26 Apr 2019 03:53:44 -0700 (PDT)
Received: from apalos (ppp-94-66-229-5.home.otenet.gr. [94.66.229.5])
        by smtp.gmail.com with ESMTPSA id 17sm22661117wrk.91.2019.04.26.03.53.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 03:53:44 -0700 (PDT)
Date:   Fri, 26 Apr 2019 13:53:41 +0300
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     Grygorii Strashko <grygorii.strashko@ti.com>,
        netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Jiri Pirko <jiri@resnulli.us>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>,
        Ivan Vecera <ivecera@redhat.com>
Subject: Re: [RFC PATCH v3 net-next 03/11] net: ethernet: ti: cpsw: ale: add
 functions to modify VLANs/MDBs
Message-ID: <20190426105341.GA22373@apalos>
References: <1556144667-27997-1-git-send-email-grygorii.strashko@ti.com>
 <1556144667-27997-4-git-send-email-grygorii.strashko@ti.com>
 <20190426104156.GA2796@khorivan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426104156.GA2796@khorivan>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ivan,

> >}
> >
> >+static int cpsw_ale_read_mc(struct cpsw_ale *ale, u8 *addr, int flags, u16 vid)
> See below.
> 
Yes
> >+{
> >+	u32 ale_entry[ALE_ENTRY_WORDS] = {0, 0, 0};
> >+	int idx;
> >+
> >+	idx = cpsw_ale_match_addr(ale, addr, (flags & ALE_VLAN) ? vid : 0);
> >+	if (idx >= 0)
> >+		cpsw_ale_read(ale, idx, ale_entry);
> >+
> >+	return cpsw_ale_get_port_mask(ale_entry, ale->port_mask_bits);
> >+}
> >+
> >+int cpsw_ale_mcast_add_modify(struct cpsw_ale *ale, u8 *addr, int port_mask,
> >+			      int flags, u16 vid, int mcast_state)
> >+{
> >+	int mcast_members, ret;
> >+
> >+	mcast_members = cpsw_ale_read_mc(ale, addr, flags, vid) | port_mask;
> >+	ret = cpsw_ale_add_mcast(ale, addr, mcast_members, flags, vid,
> >+				 mcast_state);
> By fact, cpsw_ale_add_mcast() is doing modify itself already, just name is
> different.
> 
> These 3 func duplicate the existent functionality as result code is done twice.
> Better remove/combine them and rename existent ones, like:
> cpsw_ale_add_mcast() -> cpsw_ale_add_mcast_modify()
> cpsw_ale_del_mcast() -> cpsw_ale_del_mcast_modify()
> 
Yes this is correct. The reason the duplication exists is that this was
originally coded on top of the current cpsw code. So i didn't want to change any
part of the working driver. 
Since we are re-working a bunch of stuff now this makes sense

> >+
> >+	return ret;
> >+}
> >+
> >+int cpsw_ale_mcast_del_modify(struct cpsw_ale *ale, u8 *addr, int port_mask,
> >+			      int flags, u16 vid)
> See above.
and yes :)
> 
> >+{
> >+	int mcast_members, ret;
> >+	int idx;
> >+
> >+	mcast_members = cpsw_ale_read_mc(ale, addr, flags, vid) & ~port_mask;
> >+	idx = cpsw_ale_match_addr(ale, addr, (flags & ALE_VLAN) ? vid : 0);
> >+	if (idx < 0)
> >+		return 0;
> >+	ret = cpsw_ale_del_mcast(ale, addr, mcast_members, flags, vid);
> >+
> >+	return ret;
> >+}
> >+
 
Regards,
/Ilias
