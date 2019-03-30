Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E3FC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 04:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33F162173C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 04:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KczmFX9P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfC3EtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 00:49:17 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:36903 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbfC3EtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 00:49:17 -0400
Received: by mail-ot1-f43.google.com with SMTP id c16so4045083otn.4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 21:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=NDH5M1HR79nQl3W+HKG6wYCnLsxMYX+/zRRqVQVrfXM=;
        b=KczmFX9PhAWRLEmGUqXrkikbVfe2nz/S/J8NIURlkabHFaCOI0Yjp2BvyKFwtH3Jp/
         84XHzGMfUCvGfWLKflc1Wz0Ua7HVt8tGzYN81KDF2zQQGJroevGl5t4tPRTmQFSb4HKT
         kJ1UeHopxJ7nwrRt+PvSmvL9e3uJz/9h8DHcYLrMLHJuKzE04IGJwoTy6FYjOHgRUlZh
         F8t4DQb6/xBbXkF7wnnjDNLQvrPbN8+OLM4G/EJWmIv09mPDr8S8RtFqGs1mU4oIFRhS
         NrTAdfG1egzkjVhSSNS6lHKfnOLhNYWNptz6Ak5zxfxJ3BBDDak08ui95I2poe1mvtLI
         fZxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=NDH5M1HR79nQl3W+HKG6wYCnLsxMYX+/zRRqVQVrfXM=;
        b=LxKXGeFdzDsQRt+FLNXB3tKXFiTBln80wirPAMnFrAfgJO1L/vyu8V0ERQQBY18XX9
         hGiPRbF9+EVlJL+AFpsK65SuPA0+vJmhWG6fQvB37qrnYNAAN5Ok2OVAA5QgLZFlcNQk
         4wN2ajbA99byn366nk/3dTigo/O0kVbLuAOd7CNHNC/Ta11LilPEqtqiuzDVoIfFDlY9
         9+nVSySoQXna0KQN7TRduNlt843XGceUpI76CPl0GmxfYQs2pm/ATd9Zk5n0IAMvOZta
         pEbFVb18H488QrV+SjIUaPgoABkFDebqWbDLIGt7HIi/eQJC40AI4TG6VM/hkHBUOyFP
         ClzQ==
X-Gm-Message-State: APjAAAWe7z828fyxc3/f2FACKluBgO8B5u6YU2y40nO+mkEjy2WkVyuC
        G2k810sEBCGZhNDtI2CgzMpfpEve
X-Google-Smtp-Source: APXvYqwkXvJm5McRk58CjtzUW8MVT9wofbvVukXZjd8jEM6lliX9onPNs7Slo14sFryN46sYPx60sg==
X-Received: by 2002:a9d:7411:: with SMTP id n17mr3045002otk.205.1553921356067;
        Fri, 29 Mar 2019 21:49:16 -0700 (PDT)
Received: from [192.168.0.2] ([98.156.228.54])
        by smtp.gmail.com with ESMTPSA id i203sm1631752oih.13.2019.03.29.21.49.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 29 Mar 2019 21:49:15 -0700 (PDT)
To:     "ghook@amd.com?In-Reply-To=" 
        <241612a5-b041-e419-a3bc-e2a2e6ef1687@amd.com>, joro@8bytes.org,
        jroedel@suse.de, linux-kernel@vger.kernel.org
From:   Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: Re: [PATCH] iommu/amd: Reserve exclusion range in iova-domain
Message-ID: <6311de4d-937c-6737-b97d-9849f767a3f9@gmail.com>
Date:   Fri, 29 Mar 2019 23:49:11 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Antivirus: Avast (VPS 190329-4, 03/29/2019), Outbound message
X-Antivirus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested on a Dell PowerEdge R7425 system on which this problem is easily reproducible.

Tested-by: Stuart Hayes <stuart.w.hayes@gmail.com>
