Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 783BFC43215
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 22:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5050D2072A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 22:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Nkqj7y10"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbfKOWpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 17:45:14 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40611 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbfKOWpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 17:45:14 -0500
Received: by mail-pl1-f194.google.com with SMTP id e3so5642976plt.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 14:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:to:subject:from:user-agent:date;
        bh=7Lv3OlOPwc1itG1VgoAiwhDXhnQEj1MoRWBeTDRndG4=;
        b=Nkqj7y10JNCu5K6kPudtI3lXHEwaZBSWUhX29HR/Abt8O2VfHSQU5mdiEVOiigMCw6
         zsEj8MCsojhqm3YwGiyADl9ZPM0yX8rquJ1Z0q9RlkRg3Jr8td15JaCbE8CpRk/HgDm3
         +tploRipqGjbIXjj7nLILijQjuVP6SsHpOJ5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:to:subject:from
         :user-agent:date;
        bh=7Lv3OlOPwc1itG1VgoAiwhDXhnQEj1MoRWBeTDRndG4=;
        b=EPoAK2P+u45z+txyaf/dD7tfOMXrks6A0k/gZWIyhJpe6NBDZsj870SFcAL66wfASg
         V98pPEGOVOGF+BKv53AgrYFveQGylW5E+68Lzl9KwuLYAPvlODqpepLdmg2rGI/H3Rjk
         fkEMkGuNjtOzLUDn+WKsfM/ro5rBawIf62mUTZ8q1zQJeCiU5Cd/abz5zct+F7m2dXx9
         CsJfqPR4+GATcqQRlD/WCfedrXspX5XxoirlUzYe9QVZVtB5g31kQaVubsSreN2ZGLwC
         zTMK5SJKrqp6fZJYz7A7iJeUiu/yMEGxPqqd+mqLP/DJbpebxlf2f5elVC5W/ZdrQ1MC
         e2rw==
X-Gm-Message-State: APjAAAXwe+d9IxSi717TpnWBtCQDPb+QS2T/emMjzY72+gd/9pXvSHuf
        UcDF3a44eHMOjLHmv/ILKztkiQ==
X-Google-Smtp-Source: APXvYqxKvvQFWUoIX8E+lfiE355scZNy4BpKhjdSk1Emyyc0LcYlxCPxZKzrkbThPxbIN4SfSJj3Zw==
X-Received: by 2002:a17:90a:f496:: with SMTP id bx22mr22379458pjb.126.1573857912758;
        Fri, 15 Nov 2019 14:45:12 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id k4sm11900933pfa.25.2019.11.15.14.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 14:45:12 -0800 (PST)
Message-ID: <5dcf2a78.1c69fb81.f690a.481c@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1573593774-12539-5-git-send-email-eberman@codeaurora.org>
References: <1573593774-12539-1-git-send-email-eberman@codeaurora.org> <1573593774-12539-5-git-send-email-eberman@codeaurora.org>
Cc:     Elliot Berman <eberman@codeaurora.org>, tsoni@codeaurora.org,
        sidgup@codeaurora.org, psodagud@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Elliot Berman <eberman@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCH v2 04/18] firmware: qcom_scm: Apply consistent naming scheme to command IDs
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Fri, 15 Nov 2019 14:45:11 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Elliot Berman (2019-11-12 13:22:40)
> Create a consistent naming scheme for command IDs. The scheme is
> QCOM_SCM_##svc_##cmd. Remove unused macros QCOM_SCM_FLAG_HLOS,
> QCOM_SCM_FLAG_COLDBOOT_MC, QCOM_SCM_FLAG_WARMBOOT_MC,
> QCOM_SCM_CMD_CORE_HOTPLUGGED, and QCOM_SCM_BOOT_ADDR_MC.
>=20
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Reviewed-by: Vinod Koul <vkoul@kernel.org>
> Signed-off-by: Elliot Berman <eberman@codeaurora.org>
> ---

Would be nice to state that the object file is the same before and after
this patch is applied, confirmed by compiling the file before and after
and diffing the output.

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

