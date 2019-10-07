Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE2A6C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 06:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9689C2173B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 06:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c5w+sZsl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbfJGGGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 02:06:19 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38413 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbfJGGGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 02:06:19 -0400
Received: by mail-wm1-f66.google.com with SMTP id 3so10969040wmi.3
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2019 23:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CEm8Dq+gHvKlRYIX3D4DHVP4hTzPl0SSHoUvlZDQruE=;
        b=c5w+sZslFI7kYN3wqT3QfZ5a6UJcbLAKuop9D/PBDhyPd1tOcJqDdohzGx1KWO9+Ah
         ThwXTxbdY68JkqFMc0WH7ubpac/QREJ7fXVA19NnotUz8k9OCUSaAyEkvixrqPuukdht
         G4HVnUDkxwl0fFHMQDv5VcJmkGwT45AfgV2CecB09qrz20e2m/ulziCvjOqOGXJpBifd
         8wuWeJae4TCwpdq38QEweGzv9vkhX36/ERjYqwhICbDtGIc51Ge7CUTHak3x6IjSMa9Y
         wdNbvocCxKeNaaYqp2C6SsnZ90kpVAYjEwyRXsI9zHLsCqSPVgDlYyFmAMpNB1jpkD8a
         Sfrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CEm8Dq+gHvKlRYIX3D4DHVP4hTzPl0SSHoUvlZDQruE=;
        b=E5LaJMOezlG7GbVq+hgYNd3BvTZL/V2DGeIXVoBkMtbrb60YiIh25VEWPI2BQKYBzY
         tlkG/qPXop61KipId7Xnk4sF14zHKceTEyBBt7DlaQisWYo99NHhlpRGc4gp4dEaKg+O
         QHlW8A8I4XlGVdpitpuSdpIX77nUbASs7LahCCBeFbkj//zRGDOP1f23RRsAZYJoGPIy
         TrR37h+iDaSKsLtAsFkgLO7G8W5yoNqjKNfratxV4cRIDI2HMKPnyWgcI0PyQ+gvYKkf
         WFwcxcrflbhPZg1CAhqxqddgPNTIaGTO5sUEAY7Hi2u2mW9foAELxX+AzPxCvAHCQ9c7
         wBWg==
X-Gm-Message-State: APjAAAVMyUoaXwcQHPFYUqA4lXPuwiTJBvo9u4qzbJ8y1YRJB1s4rik7
        zLpV2wxPeZXXLuRC4ShLebxdmQ==
X-Google-Smtp-Source: APXvYqzEilrT3Y/PEEjuzLNBaRDRbwwub7XVBvYLv+nEEqQ6Kin6vbPBS+iL3t3+Te2iLskFSMGb/Q==
X-Received: by 2002:a7b:c258:: with SMTP id b24mr18662316wmj.21.1570428375566;
        Sun, 06 Oct 2019 23:06:15 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:e8f7:125b:61e9:733d])
        by smtp.gmail.com with ESMTPSA id x2sm17464941wrn.81.2019.10.06.23.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2019 23:06:15 -0700 (PDT)
Date:   Mon, 7 Oct 2019 07:06:14 +0100
From:   Matthias Maennich <maennich@google.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Adam Zerella <adam.zerella@gmail.com>,
        Jessica Yu <jeyu@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc: move namespaces.rst out of kbuild directory
Message-ID: <20191007060614.GA142813@google.com>
References: <20191007043611.31036-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191007043611.31036-1-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Mon, Oct 07, 2019 at 01:36:11PM +0900, Masahiro Yamada wrote:
>I did not notice this document was added to Documentation/kbuild/,
>and I do not understand how it is related to the build system.
>
>Kick it out of the kbuild directory.
>
>I am not sure if this is the perfect place, but I added its index
>close to the module-signing.

When searching for a place for this documentation, kbuild/ was the
closest I could find. admin-guide/ seems to target system administrators
while the symbol namespace feature documentation is relevant for kernel
developers. I am ok to take maintainership for the file, but the new
location suggested seems not to be a good fit either.

Cheers,
Matthias

>Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>---
>
> Documentation/admin-guide/index.rst                  | 1 +
> Documentation/{kbuild => admin-guide}/namespaces.rst | 0
> MAINTAINERS                                          | 1 +
> 3 files changed, 2 insertions(+)
> rename Documentation/{kbuild => admin-guide}/namespaces.rst (100%)
>
>diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
>index 34cc20ee7f3a..ca632fda700f 100644
>--- a/Documentation/admin-guide/index.rst
>+++ b/Documentation/admin-guide/index.rst
>@@ -65,6 +65,7 @@ configure specific aspects of kernel behavior to your liking.
>    parport
>    md
>    module-signing
>+   namespaces
>    rapidio
>    sysrq
>    unicode
>diff --git a/Documentation/kbuild/namespaces.rst b/Documentation/admin-guide/namespaces.rst
>similarity index 100%
>rename from Documentation/kbuild/namespaces.rst
>rename to Documentation/admin-guide/namespaces.rst
>diff --git a/MAINTAINERS b/MAINTAINERS
>index 55199ef7fa74..91815dcc5914 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -11547,6 +11547,7 @@ NSDEPS
> M:	Matthias Maennich <maennich@google.com>
> S:	Maintained
> F:	scripts/nsdeps
>+F:	Documentation/admin-guide/namespaces.rst
>
> NTB AMD DRIVER
> M:	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
>-- 
>2.17.1
>
