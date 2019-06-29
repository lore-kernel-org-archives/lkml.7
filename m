Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B628C4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 15:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42D58216FD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 15:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="cLCbwk28"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfF2PMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 11:12:46 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40732 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbfF2PMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 11:12:46 -0400
Received: by mail-wr1-f67.google.com with SMTP id p11so9210460wre.7
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2019 08:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dVDtvJVRSlA4d8VkLhve/kzuWbU96ZchmdS6j4B86+g=;
        b=cLCbwk28ryGZwqwhSd9gUeaiBzTHhZyCTLyNTlljmby8i+KUmqY45sqgSdIwI2X9Ck
         mARdHWiNEgwlqwptxL5CL/xYjXN3zIeWoWlLR7dzXOcA4/WpcrxrN13zezsLqlYvFfX0
         SQZO9qo4pR0YRvffALIt6CZB6ZXLLuXMkdHzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dVDtvJVRSlA4d8VkLhve/kzuWbU96ZchmdS6j4B86+g=;
        b=Exg4QX825iqLs49YNdOF9PkRTCeSl5yUP3IOSSMxz0YocYuzjM8uBRUOGkU9bUkUG3
         W7bfuVMEnOBxw2nsIKxNrao455jzeHGWLn1tTiHi0oSy1OVmKegBm7t7dPC3I/KAzBUG
         h77OTwDw5H/nNKnTT0pBiGEQGINsffWGIcmeu9ZQqSYLudyZ/k3BFnEbXDj+YVoZV2WD
         LmXkZk59Uu3x/eRb7mKu0Z/B8xxiCgp17yXzenleoXpibfHzMahgUVHsfr7dKjypYTPV
         d0TV+npX8QKCqSvxnpbytHGs5EFqB3ecTdikFlOateLbDoSrRNQzeMPWU6vgkXqHcbV/
         m/8A==
X-Gm-Message-State: APjAAAV4zh6QSRjw00PgZvWV2hO762RrVIVTEKbVHIPpTUUBbLrnKox4
        LteyjVFhAq9wHhvWiLFtRv71sg==
X-Google-Smtp-Source: APXvYqwTjOfMVHuyb/3tQASfuN7qasFY1W08+/nCnEl3ndYSZDE84L85zG3fEjMWtAzDuG18YHCAIg==
X-Received: by 2002:a5d:494d:: with SMTP id r13mr12720134wrs.152.1561821164082;
        Sat, 29 Jun 2019 08:12:44 -0700 (PDT)
Received: from andrea (86.100.broadband17.iol.cz. [109.80.100.86])
        by smtp.gmail.com with ESMTPSA id c1sm10896319wrh.1.2019.06.29.08.12.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Jun 2019 08:12:43 -0700 (PDT)
Date:   Sat, 29 Jun 2019 17:12:36 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Byungchul Park <byungchul.park@lge.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Scott Wood <swood@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [RFC] Deadlock via recursive wakeup via RCU with threadirqs
Message-ID: <20190629151236.GA7862@andrea>
References: <20190627155506.GU26519@linux.ibm.com>
 <CAEXW_YSEN_OL3ftTLN=M-W70WSuCgHJqU-R9VhS=A3uVj_AL+A@mail.gmail.com>
 <20190627173831.GW26519@linux.ibm.com>
 <20190627181638.GA209455@google.com>
 <20190627184107.GA26519@linux.ibm.com>
 <13761fee4b71cc004ad0d6709875ce917ff28fce.camel@redhat.com>
 <20190627203612.GD26519@linux.ibm.com>
 <20190628073138.GB13650@X58A-UD3R>
 <20190628104045.GA8394@X58A-UD3R>
 <20190628114411.5d9ab351@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628114411.5d9ab351@gandalf.local.home>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

> As Paul stated, interrupts are synchronization points. Archs can only
> play games with ordering when dealing with entities outside the CPU
> (devices and other CPUs). But if you have assembly that has two stores,
> and an interrupt comes in, the arch must guarantee that the stores are
> done in that order as the interrupt sees it.

Hopefully I'm not derailing the conversation too much with my questions
... but I was wondering if we had any documentation (or inline comments)
elaborating on this "interrupts are synchronization points"?

Thanks,
  Andrea
