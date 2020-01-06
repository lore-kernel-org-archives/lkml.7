Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3DCBC00523
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 01:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8784E21734
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 01:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="eeXy++9V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbgAFBui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 20:50:38 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:33502 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727270AbgAFBui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 20:50:38 -0500
Received: by mail-io1-f65.google.com with SMTP id z8so47054316ioh.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jan 2020 17:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=VdfYfcG5q1NyFiFXYXaUTE1whOJmabFbb1jufVcSpNI=;
        b=eeXy++9VzngyMEB/0k4M6iH/GjyUpFOnbDJCiIkbbm6/RIwHHyVylyEQ2emB6Jmt0B
         Ey43n3ErHFXltbzX74bKzN7M0sKo02Op0k5a2+tkHbcxII03JSpVjmibmFpUYQZJMB+f
         MSEGLwh5GjnwtOnqRS3o66SUc3XP2VfXwd+iDuWduOukvK+uxnkQWdYc/amwy/RpB54n
         48jCh3KwpY3Vqc+vm8YwgTEk3Ijsr8sn5Lqs+ktIUgAmJmIl3XXVTVGw9o+0Na4lr0bZ
         OCwFdWhovdqIrX5I0j1XznJnXhpiqn5nX4aoMz8YKxptczjgO6AXnwrg6dAhD6zrbI7l
         YK1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=VdfYfcG5q1NyFiFXYXaUTE1whOJmabFbb1jufVcSpNI=;
        b=c1gAsJit1/u4IYtbzD/AjfH2Y72UBhqI36A54hxR4sW/lT2RcFR51ep/DTgbKZyFCQ
         ykVdsgkI2fUTmIPdZvAe0cJZUIVG3eqchJaoIGCIsY2vTHDfpyQQSpM08urJarnVPtcH
         /gZXqhZjXcIk1RfcUwupdByUMzACMTmXmfv/Q+LSgY6SM8VNcNmZVaQblr9IV/46eC83
         FQxlPM60tyWN0yHMdaECw8NqPm6Z73TYe/Cnsm+RgM6nidyNQnTd8coEIU+J4ETEMggI
         pkdCYvPCgzj3TsReaf3+0Zjjnu1r4pQ5NjDoA3zdhhCqPKLHPi4SSeVeq5jscEkwB6N3
         CuEg==
X-Gm-Message-State: APjAAAVrCth8Lc4Faw0lC4vs8FYkgPBSgEDGY6SKwYZlgqoiK0KoVe0I
        +ZnbxC3Gsn+uxyXaB8RzUTS7mQ==
X-Google-Smtp-Source: APXvYqymJINXQwafxuveL/Fa0mW5ldqpklrKDw9WhQEWFERck5saRPT6P7hvfY9QBdWsOGkXLeRrnA==
X-Received: by 2002:a6b:c9c6:: with SMTP id z189mr64169930iof.285.1578275437348;
        Sun, 05 Jan 2020 17:50:37 -0800 (PST)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id y18sm16204591ilm.9.2020.01.05.17.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2020 17:50:36 -0800 (PST)
Date:   Sun, 5 Jan 2020 17:50:35 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Stephen Rothwell <sfr@canb.auug.org.au>
cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul@pwsan.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: manual merge of the risc-v tree with Linus' tree
In-Reply-To: <20200106093246.6abbb7e9@canb.auug.org.au>
Message-ID: <alpine.DEB.2.21.9999.2001051749560.484919@viisi.sifive.com>
References: <20200106093246.6abbb7e9@canb.auug.org.au>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Mon, 6 Jan 2020, Stephen Rothwell wrote:

> Today's linux-next merge of the risc-v tree got a conflict in:
> 
>   Documentation/riscv/patch-acceptance.rst
> 
> between commit:
> 
>   0e194d9da198 ("Documentation: riscv: add patch acceptance guidelines")
> 
> from Linus' tree and commit:
> 
>   d89a1a16d7dc ("Documentation: riscv: add patch acceptance guidelines")
> 
> from the risc-v tree.
> 
> I fixed it up (I used the version from Linus' tree as that was committed
> later) and can carry the fix as necessary. This is now fixed as far as
> linux-next is concerned, but any non trivial conflicts should be mentioned
> to your upstream maintainer when your tree is submitted for merging.
> You may also want to consider cooperating with the maintainer of the
> conflicting tree to minimise any particularly complex conflicts.

Thanks, I just reset our for-next branch to v5.5-rc5, so this won't 
reappear.

- Paul
