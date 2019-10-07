Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49203C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 07:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1320D21655
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 07:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5ZsFrWz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfJGHVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 03:21:43 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:44282 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfJGHVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 03:21:42 -0400
Received: by mail-wr1-f54.google.com with SMTP id z9so13801960wrl.11
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 00:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=+S74GriLzHisA5zCNtp+YX4eA5WLKdq2ZT+2hpOIbsA=;
        b=R5ZsFrWz+ng+i2GRGRriJqk2TmNGUgVNmxQu/DZSeREJiNkwdHuQi74V8BQyaUioyT
         OhbPs9g1dA0kWHZDqfTqglmTo1wYL4RS9+1O0a/38EhiiFYMlNTE1WVVSGe9B3H/J6fX
         uG7afwzg/SHDnd3klcLnij3GTwpLM/PvTD+7bvrDqxF/+48E/pINbBpvHAvmK/JtQR0s
         m2bDGLblCZ6RUCMf5Ecd99RqW64eTV+eOJ7GTYF3gJIH1sh/HhcCpQgVQAjZ9rHTw1uo
         dLNgaV4DOKGL5ba5pujiF5YQ1vuhALNxIp/v0qmrST5X20wZvjN19H0r+PI6/pH2w9si
         UAMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=+S74GriLzHisA5zCNtp+YX4eA5WLKdq2ZT+2hpOIbsA=;
        b=QWL9jr2HA9+nUX7K5o7GWQcnWhNWulDL1YzvAWhw6dXD03U3OU8ciRuiboicuS+qMg
         9TcEEMfaKdVwp0htRMBdwo47321FMx+jKOt51LHwlVjRg0w5k4zrrguVLreHHuhnV6Q2
         SutQ9J/kkDBGyD+tEl66nWau+hfwqfevxtUmjj+wfvvzzzVB5+IBKKq9bT0GJNMIHBUe
         Td2eHTt3dlg8Cv2GLbqiy9lsB3mXX0OwJBup84M0gaO3vHJiTpyljhVXDMhSrR4ijLwh
         p29FCwYHp4/yfOWmHrvKUCZ3SY1+V7kR3bVbn/+6ADK0Xk1AkWpiq8JBqZCD2u16CLvQ
         AJvQ==
X-Gm-Message-State: APjAAAUmMjTsOFu/kYY+25fJjD1wOrUnd+y6CY7CR+iavoD+e1n/FxAT
        cfQ0KN0Aseq0HLYBYrwR1Gw=
X-Google-Smtp-Source: APXvYqzPS/luRfsU+e0xh0/CHS+mNlq9Sn6Bql6hE90Y4vh/Pn1egdNdR6ElbLKSlliopjdogDKqhg==
X-Received: by 2002:a05:6000:14c:: with SMTP id r12mr20971445wrx.303.1570432900469;
        Mon, 07 Oct 2019 00:21:40 -0700 (PDT)
Received: from ?IPv6:2a00:23c4:f78c:d00:1570:f96d:dab8:76ae? ([2a00:23c4:f78c:d00:1570:f96d:dab8:76ae])
        by smtp.gmail.com with ESMTPSA id f3sm16361804wrq.53.2019.10.07.00.21.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 00:21:39 -0700 (PDT)
From:   Carlo Caione <carlo.caione@gmail.com>
Subject: [BISECTED] Suspend / USB broken on XPS 9370 + TB16
To:     linux-kernel@vger.kernel.org
Cc:     andrew.smirnov@gmail.com, rrangel@chromium.org,
        mathias.nyman@linux.intel.com, gregkh@linuxfoundation.org,
        kamal@canonical.com, khalid.elmously@canonical.com
Message-ID: <2f2f62bc-558f-70d1-44bf-a95334453f8a@gmail.com>
Date:   Mon, 7 Oct 2019 08:21:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I bisected an issue down to commit f7fac17ca925 "xhci: Convert 
xhci_handshake() to use readl_poll_timeout_atomic()".

Setup:
XPS 9370 + Thunderbolt dock Dell TB16

Issue:
The laptop is unable to go to sleep. It never really goes to sleep and 
after a few seconds the USB dies.

Log:
https://termbin.com/icix

Cheers!

-- 
Carlo Caione
