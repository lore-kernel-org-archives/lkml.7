Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D53FC3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 13:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D13222CE9
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 13:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qf+PO/6d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbfIANAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 09:00:33 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35512 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728552AbfIANAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 09:00:32 -0400
Received: by mail-wm1-f68.google.com with SMTP id n10so1251490wmj.0;
        Sun, 01 Sep 2019 06:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/kY5ez2UY78GlNnuNQzpPG/veO6d9ypsF/qsZ3kn5iE=;
        b=Qf+PO/6dtwNFaVxqtGJzKTaKniz8RX6ESuac+SqGHXNMJroDYDHse2EpvXnI1uqf1j
         BFOg7dyecrIKQlEXcTKZy2diaA7VNcMszCo2/IL5OLspUAl13UwTCG8IWjkAmcPL9H9n
         kvHwSsgaOB9kHEHzHT5ikPvuq64SnOL1Cx40FuPBcFOUzURaUp2NyFqwmE33tMv8lZKo
         WdA88vtnDPwjExBd6zXOiL9FU5nW+3oy0wiyMaZ+iDKi7j/WBZTMckmQ0Mlwm1vtsYgv
         h3hLM7uWQTVZI53G1+VNqw0iJdQrTC7GiQxyqiYPofVd5jgNMIc5iPNyLIxsLLv1JpkX
         pSeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=/kY5ez2UY78GlNnuNQzpPG/veO6d9ypsF/qsZ3kn5iE=;
        b=amx/YydvT219raV6mzFJKNUmFNXAXZet+ITpw7di6Zx5FklziqtsIKn23fsW3OY+Ov
         yIiOig1z0ZPppPDPJBCmlKZVmBQ1i8XZOSEEf7EF4sBCcIQC8yke5vNgAYWDi+z80CIq
         ZdVl1Cd8celDZp7/yf6WCBdSmDICYFxS3Pvpz+/5Ii6qX0TwRRbZfaYveSQVYa2A6arx
         PyW4lahbfaL/SAneqbE+mrsIAqk1/HNkil0JBnEJCv3lJ/hXj86Iys4jO4zLXQqV5E+z
         yQ3L65R1VUXAfgQ2AisSxL4QKs/lzXQOx8i4g5kqgumAUjli43jC95X0XhjpNAQBixTQ
         FloQ==
X-Gm-Message-State: APjAAAU+ROxHkkNfWkX70ZBkatMM1aHPyl0REGHexKmj/Npidkt3Xldp
        GrlcRWwgre4LM3/FLB1g1qlnY4T1ZNU=
X-Google-Smtp-Source: APXvYqyhivmpE3lMGP6u1JMIOvrjJ4rxcsVaL4kw5hjjdftxOOcZ52sYnbiN8SIqnrz1+BPycOIUSg==
X-Received: by 2002:a1c:9d0b:: with SMTP id g11mr29085302wme.22.1567342830477;
        Sun, 01 Sep 2019 06:00:30 -0700 (PDT)
Received: from eldamar (host85-134-dynamic.30-79-r.retail.telecomitalia.it. [79.30.134.85])
        by smtp.gmail.com with ESMTPSA id o11sm11093069wrw.19.2019.09.01.06.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2019 06:00:29 -0700 (PDT)
Date:   Sun, 1 Sep 2019 15:00:28 +0200
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Hui Peng <benquike@gmail.com>
Cc:     stable@vger.kernel.org,
        Mathias Payer <mathias.payer@nebelwelt.net>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wenwen Wang <wang6495@umn.edu>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Fix a stack buffer overflow bug in check_input_term
Message-ID: <20190901130028.GB23334@eldamar.local>
References: <20190830214730.27842-1-benquike@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830214730.27842-1-benquike@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hui,

On Fri, Aug 30, 2019 at 05:47:29PM -0400, Hui Peng wrote:
> `check_input_term` recursively calls itself with input from
> device side (e.g., uac_input_terminal_descriptor.bCSourceID)
> as argument (id). In `check_input_term`, if `check_input_term`
> is called with the same `id` argument as the caller, it triggers
> endless recursive call, resulting kernel space stack overflow.
> 
> This patch fixes the bug by adding a bitmap to `struct mixer_build`
> to keep track of the checked ids and stop the execution if some id
> has been checked (similar to how parse_audio_unit handles unitid
> argument).
> 
> CVE: CVE-2018-15118

Similar to the previous one, this should be CVE-2019-15118 as far I
can tell.

Regards,
Salvatore
