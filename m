Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E641CC04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 13:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B764E20820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 13:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UG4ze4Be"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408167AbfIWNxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 09:53:19 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44537 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405257AbfIWNxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 09:53:18 -0400
Received: by mail-qk1-f196.google.com with SMTP id u22so11942564qkk.11;
        Mon, 23 Sep 2019 06:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wJcd7nYtvU6DBwiU2kjKXaOb9CLVimR3A9FZNSBStXM=;
        b=UG4ze4Be+641vQispOBF1W0343NdEvRz9q5A96Vr9UG5g1XcOrIeF9lz21yGYnXOaS
         Do0fJ17oVqN5eSbs5dnqnMruwuIWry705BWTCD21ZOv4Lh/GbgsmtDKF/SpRH2ITSw7E
         5QtGB85mj/hlBUoGbArK9qlJegyfUbgZ/XYPEjntMo3qOYZsBFqQ5x5TraGTVut3pCf5
         gNWAUwocF0UgZ7FPbuzP0VWgWmTH06kyYPNGpfTgnafDtL6fN+DB1yVVIJLQuB4tUtg2
         Khe7CEAKsUBmhsXEVrPfLS4ZGdz1mzBMJ5NVCzSY6Lu7ICjltMAY9wKKUSpZseR9SJdO
         oAVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wJcd7nYtvU6DBwiU2kjKXaOb9CLVimR3A9FZNSBStXM=;
        b=ebb3qo486xyVVs5T/wOPY9YPTcUuunJNlUXoA4tD+cc6jXfhDEtDMVBJAHNiOiqCBf
         Eul3FIALw/neoCGko0fslhMqpV5tzkdOPRlu3EbO/hxUt8eGb0dzVZSBJ1SrYeZW7t4C
         wiO2cwKZbywwAVIYZfQk/5d7GD2F3YWqVm8FWaiA4R+rfMlu+Lqf/9tphM+k7LrR72p5
         Rn79jD7I++fKhWlWz6gLRguDo1WVuK7QvnazZymDFZVDhRlTAhpRlLz77re4lCBqMTz2
         GWtR0soDbYiHMsmfQ615tIaY4GclnL+YqxXYEV9qcPXpxlwfTee87CwW40ox4QLLdiB7
         oQNg==
X-Gm-Message-State: APjAAAU7pC3N28vAMjwmn8qN01n1j/8XpUlDa5bMWDzWSkVDEYhpmt+q
        5fq1CzXYYZ1tDk0OQ7Z6/OE=
X-Google-Smtp-Source: APXvYqxPy5fZ0Wf23qq6HNNiyrRkJRPODTCUydnFrgNE7NPiQT21bSGSQQWRQYUeRUIQPri0VGCXJA==
X-Received: by 2002:a05:620a:148d:: with SMTP id w13mr16953041qkj.14.1569246795809;
        Mon, 23 Sep 2019 06:53:15 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id k2sm5712059qti.24.2019.09.23.06.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 06:53:15 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3F82041105; Mon, 23 Sep 2019 10:53:12 -0300 (-03)
Date:   Mon, 23 Sep 2019 10:53:12 -0300
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Kim Phillips <kim.phillips@amd.com>,
        Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Borislav Petkov <bp@suse.de>, Martin Liska <mliska@suse.cz>,
        Luke Mujica <lukemujica@google.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 3/5] perf vendor events: minor fixes to the README
Message-ID: <20190923135312.GB16544@kernel.org>
References: <20190919204306.12598-1-kim.phillips@amd.com>
 <20190919204306.12598-3-kim.phillips@amd.com>
 <20190919220928.GH8537@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190919220928.GH8537@tassilo.jf.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Sep 19, 2019 at 03:09:28PM -0700, Andi Kleen escreveu:
> For all the patches except the last
> 
> Reviewed-by: Andi Kleen <ak@linux.intel.com>

Thanks, applying all but the last till we get that further discussed.

-- 

- Arnaldo
