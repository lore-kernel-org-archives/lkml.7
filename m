Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B777C4CEC9
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 08:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 439FF208C0
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 08:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="UdK7rtRd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437861AbfITIsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 04:48:04 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34697 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437842AbfITIsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 04:48:03 -0400
Received: by mail-qt1-f196.google.com with SMTP id 3so5335625qta.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 01:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=0ghb2ofoQaWYR79lBqsKSuBtiFPcVpCWcmnaiOOknyg=;
        b=UdK7rtRdmjoms5ysOvQapgLVFBipggdRniC9S94pv9NhHQCFd2aVrGAdK2rzjD6akG
         Yf8ycU1kg+M6bOXq0f15wgCxnNprnGI/gc2rCxE9KqAVVtlgfkVRbVFD6QWobsi8W263
         efuNNhPLvEviZp+j+EWYx7ydei3p5mcg/VQI8ai1CGq2dhk2Of1jy0IjVWAnv4sT86t6
         Xx3fZnHGhpYzgxN3rQwOYno/wCgehqisSaWqo6O/AmwyDQEcBVDPhMqHGxg4dRTNY3VF
         3fQpH9Q+2KKsjirkPFVgsKrelftHn3GoWC1k+gT9vGTKk5NJGVmzWgg0mrO9kxhw4GFz
         9j2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0ghb2ofoQaWYR79lBqsKSuBtiFPcVpCWcmnaiOOknyg=;
        b=bP9XG1tlpmlTvlYJg97S7j15yP3VLKYNBLVDEVfds/Dm+NUdFcG2yZD01JVze1FCEq
         BBY3x6nGaMUYbKm4k3/jVcbgVhEWGEOApIaaBK7Uj566rdTAEbekNBbfJu7cCjd3n999
         zSfhoQNPSOg7DCI3zYqPF7/qZsJ27m/EsIhIuwAHaOJy8zlr33La/geytFJK+0jOnUV2
         WhTRlARrIDS2P4EeMOppYVWZ98K3obFIKJ/zUiDaK8AjXKfAAEbqtr8iyMF23ZMhrkHf
         uvvaiIBYnsGmwZUy1dB4FG5oVrOpoyBF2+yyoP1jTLybZ0KCtvCeZQAeeTA0ZgsiKg6F
         16bw==
X-Gm-Message-State: APjAAAWszyQ0Y6877JooqJ9LrKuaTL/56BH+hOkKgV/adNT5Ujmf0sw4
        7NrvoO5JDPZiMWG3mrrm7Zz3pA==
X-Google-Smtp-Source: APXvYqwOfEkZdd8pxj56VhHGXpmptTJLeojyZODLnOylGmjCMZvNA8CWEC3PiyQA78uxaUnCTZkJ1Q==
X-Received: by 2002:a05:6214:1231:: with SMTP id p17mr12236189qvv.170.1568969280324;
        Fri, 20 Sep 2019 01:48:00 -0700 (PDT)
Received: from cisco ([192.241.255.151])
        by smtp.gmail.com with ESMTPSA id z141sm693660qka.126.2019.09.20.01.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 01:47:59 -0700 (PDT)
Date:   Fri, 20 Sep 2019 10:47:53 +0200
From:   Tycho Andersen <tycho@tycho.ws>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     keescook@chromium.org, luto@amacapital.net, jannh@google.com,
        wad@chromium.org, shuah@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Tyler Hicks <tyhicks@canonical.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH v2 2/3] seccomp: avoid overflow in implicit constant
 conversion
Message-ID: <20190920084753.GA16893@cisco>
References: <20190920083007.11475-1-christian.brauner@ubuntu.com>
 <20190920083007.11475-3-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190920083007.11475-3-christian.brauner@ubuntu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 10:30:06AM +0200, Christian Brauner wrote:
> USER_NOTIF_MAGIC is assigned to int variables in this test so set it to INT_MAX
> to avoid warnings:
> 
> seccomp_bpf.c: In function ‘user_notification_continue’:
> seccomp_bpf.c:3088:26: warning: overflow in implicit constant conversion [-Woverflow]
>  #define USER_NOTIF_MAGIC 116983961184613L
>                           ^
> seccomp_bpf.c:3572:15: note: in expansion of macro ‘USER_NOTIF_MAGIC’
>   resp.error = USER_NOTIF_MAGIC;
>                ^~~~~~~~~~~~~~~~
> 
> Fixes: 6a21cc50f0c7 ("seccomp: add a return code to trap to userspace")
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> Reviewed-by: Tyler Hicks <tyhicks@canonical.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: Will Drewry <wad@chromium.org>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Martin KaFai Lau <kafai@fb.com>
> Cc: Song Liu <songliubraving@fb.com>
> Cc: Yonghong Song <yhs@fb.com>
> Cc: Tycho Andersen <tycho@tycho.ws>

You can also add,

Reviewed-by: Tycho Andersen <tycho@tycho.ws>

for this one.

Tycho
