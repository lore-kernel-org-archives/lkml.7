Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE428C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C05942054F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dt5Hj+14"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391867AbfETOrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 10:47:15 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36697 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387992AbfETOrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:47:15 -0400
Received: by mail-qt1-f196.google.com with SMTP id a17so16640651qth.3;
        Mon, 20 May 2019 07:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GrBSD2oTzT6Za/pH9I+6y3E5QTGBGNREi52pUy2AGCo=;
        b=dt5Hj+14YN4Qx35l2bBCMhmZyP7P/cJ/woxmew6tnzhiWKaI7m29H0YPGJO79atC5i
         V0itOx5bUq9J2vWgS/ACmVs0XxsbaGhlQHg7v2qgRw6axVe5Apf1H87UZwDt9K/wVhGX
         tG7JpPC/cIDfjNPd7nyAs9iiPyOVoWZFtfF4meUHOo56213U2R3rpTLirOlyLEsnZACj
         BfiWtyy0nLfhGpH2Rx6iRtyGa7bGJVgjFXm4rGzUx9Xm+OJIclUIDJL4wKmBbKEx7vpV
         kGbD/aMQjhCCy2vrZEtjQiGrsv7K3/t9hM0Kv5DojCLjXuLGVAUrz0NGYcy6OGwMoqwn
         ypiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GrBSD2oTzT6Za/pH9I+6y3E5QTGBGNREi52pUy2AGCo=;
        b=Pcjy72tcIp97oU6xxPjEXYfDqyfTQty8XeUcMOceAfMl7g81+HUEs4ygi5vwINCtEF
         UN5VERryM9z9XF997WvqSEaP4QAgGMDx7e278VtvloJLUrWAqBF/mg+aGCzMR5N8ZEFB
         2NelbIpzNQCZfYs3oat+cLRxbXhvlQOfslWq46w7MUCtQs6RWnrCahQoUlKQ9RprA530
         4KeDGsO5P1RzAj2rkjt5M8YnRI0JuznjwosLOOvJV3/Amd5eNRi65C3ZbVX/iLVDvdag
         k4MT156h36Wu/c4ZA4NzW8ywnJaOBKbvPEYRHMijKRzEgXk0ketDKkLenk6JGFMEFje/
         NE9Q==
X-Gm-Message-State: APjAAAUch89FpRXWZv7bGxNyPuURtB9Ke6N/pDLTvWDS/+KAdGhqbBD5
        z8r6wcXd8Z+T76QDK8JPBIw=
X-Google-Smtp-Source: APXvYqzN88Zsli1FBeLYOmv/DK14XNHLxTvV31o2fVFlMVlaDybEgwrmG5G3xP7ZPTwbgnaAIy2MNQ==
X-Received: by 2002:ac8:fdd:: with SMTP id f29mr15757296qtk.17.1558363633805;
        Mon, 20 May 2019 07:47:13 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([177.195.215.206])
        by smtp.gmail.com with ESMTPSA id v12sm3887069qto.15.2019.05.20.07.47.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 20 May 2019 07:47:12 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9FC12404A1; Mon, 20 May 2019 11:46:48 -0300 (-03)
Date:   Mon, 20 May 2019 11:46:48 -0300
To:     Donald Yandt <donald.yandt@gmail.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Avi Kivity <avi@scylladb.com>, Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Yanmin Zhang <yanmin_zhang@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH 20/73] perf machine: Null-terminate version char array
 upon fgets(/proc/version) error
Message-ID: <20190520144648.GM8945@kernel.org>
References: <20190517193611.4974-1-acme@kernel.org>
 <20190517193611.4974-21-acme@kernel.org>
 <2D532F76-A57F-4CC4-BAA5-B466AFC0305D@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2D532F76-A57F-4CC4-BAA5-B466AFC0305D@gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, May 17, 2019 at 08:05:39PM -0400, Donald Yandt escreveu:
> Thank you Arnaldo for signing my patch.
> 
>      I think we should use version 4 of my patch and return NULL instead of null-terminating for efficiency.

Please resubmit then, v3 is already upstream.

- Arnaldo
 
> Thanks,
> 
> Donald
> 
> > On May 17, 2019, at 3:35 PM, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > 
> > From: Donald Yandt <donald.yandt@gmail.com>
> > 
> > If fgets() fails due to any other error besides end-of-file, the version
> > char array may not even be null-terminated.
> > 
> > Signed-off-by: Donald Yandt <donald.yandt@gmail.com>
> > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Cc: Avi Kivity <avi@scylladb.com>
> > Cc: Jiri Olsa <jolsa@redhat.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Yanmin Zhang <yanmin_zhang@linux.intel.com>
> > Fixes: a1645ce12adb ("perf: 'perf kvm' tool for monitoring guest performance from host")
> > Link: http://lkml.kernel.org/r/20190514110100.22019-1-donald.yandt@gmail.com
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> > tools/perf/util/machine.c | 3 ++-
> > 1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> > index 3c520baa198c..28a9541c4835 100644
> > --- a/tools/perf/util/machine.c
> > +++ b/tools/perf/util/machine.c
> > @@ -1234,8 +1234,9 @@ static char *get_kernel_version(const char *root_dir)
> >    if (!file)
> >        return NULL;
> > 
> > -    version[0] = '\0';
> >    tmp = fgets(version, sizeof(version), file);
> > +    if (!tmp)
> > +        *version = '\0';
> >    fclose(file);
> > 
> >    name = strstr(version, prefix);
> > -- 
> > 2.20.1
> > 

-- 

- Arnaldo
