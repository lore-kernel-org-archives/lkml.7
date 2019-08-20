Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4975C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 19:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9795D214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 19:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uImjsq2A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730773AbfHTTpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 15:45:05 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33828 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729950AbfHTTpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 15:45:05 -0400
Received: by mail-qk1-f193.google.com with SMTP id m10so5565898qkk.1;
        Tue, 20 Aug 2019 12:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ra6KKZYkJIejmc4d4MQLIrQnZErcyxLUq9lByOVwzEI=;
        b=uImjsq2AZhNJWvdhF0nI9TFQgqWUH8a98NhnpYsVTuhduJUodXhAgdXjXv4/nreHhh
         yU8za2l7rKYyEzN15G9rYme95iWUAck9jfgyTq7kNl6iVYph2LM4/tFP3dZ5ZmDvtCBE
         Xj5WLet732AHQxe4ik3jijNqu0oOz3HVJk/FirFQWVil2wAHQvf/2atwxZKVkmAER1EK
         xAMLxlTM6oM7+cXIX+sEwFLxR7JPd9fDusIdp/9lEBghuHgrGU1qTqfR1TUsv8ua8Nvp
         tbMEBwrizKjYXcDZ+r7MxswN4JvelD/fR2cInJHx+AyLWTLJIp3N2GmJSNSKGlOIna+0
         vOOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ra6KKZYkJIejmc4d4MQLIrQnZErcyxLUq9lByOVwzEI=;
        b=afr1KtfZ8oi0OLrkKyltDU0eEnEWvohHXDQKdN3o2d7e7YLd1beUGnOCTZZqbdlDPm
         GLY8C82HH2rprOFgQhDg1uqw1ZEmni/UdXylER41zfag1KxRrQbAca2OktBLb4DAJK6+
         JlVWNa3skcZqRwf1qU9n19R6yXZFZxzCy8GM2cEq+ulueKcwWg3M5/lD0KrlZnosB4Db
         /k7X/Fa/1GPLEYPftcC9s1u1gymA9ARAiC4SCJBMVQMC7+9n/8hcew5TRPyEyqLk9txt
         PW7RkqAILp4f594uuuj8YZazCAulK9kZwjN33db1hkY+/dXkehVtFX/QhsE93rXzrign
         CBlQ==
X-Gm-Message-State: APjAAAUkT5waY3G4OFfRKdKKrApMVDXdbPM0pA/jz0FKuLFz22yJjP3o
        jnMSE4jc6rbCto0lR2bz3NU=
X-Google-Smtp-Source: APXvYqzPoHxz3gkWOp285wsaLD7Lt0YB5H4/T/OwU4paWwCoxIN/FqMRJDWStLmE8IahPBqe+3iKtQ==
X-Received: by 2002:a05:620a:78f:: with SMTP id 15mr26223776qka.441.1566330304069;
        Tue, 20 Aug 2019 12:45:04 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([2804:1b1:210b:5274:a5b1:5d35:10b8:55f7])
        by smtp.gmail.com with ESMTPSA id 6sm9725623qkp.82.2019.08.20.12.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 12:45:02 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5B2C840340; Tue, 20 Aug 2019 16:44:59 -0300 (-03)
Date:   Tue, 20 Aug 2019 16:44:59 -0300
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL] perf/core improvements and fixes
Message-ID: <20190820194459.GF3929@kernel.org>
References: <20190820192733.19180-1-acme@kernel.org>
 <20190820193953.GA12100@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820193953.GA12100@gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Aug 20, 2019 at 09:39:53PM +0200, Ingo Molnar escreveu:
> Pulled, thanks a lot Arnaldo!

Wow, that was fast, thanks!
 
> This one's very nice:
> 
> > Arnaldo Carvalho de Melo (10):
> >       perf top: Show info message while collecting samples
> 
> :-)

Yeah, we need to polish these kind of little details, pressing 'C' and
getting callchains enabled/disabled would be nice as well in 'perf top',
just thought about that :-)

- Arnaldo
