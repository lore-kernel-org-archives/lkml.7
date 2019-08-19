Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96281C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 19:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59F5B2087E
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 19:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566242013;
	bh=qZ2aBkl9CiqwFz/ZVGluogUZHqgRhHrcujNhP34JiU4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tgj6/ju42W03aCoP4ykkS1GLzazirjaABa8GqIkcx1VDyQ6/TKS05bRQTBYM/TKwL
	 3YVQXaQinUKbJhcN89ykzSrrawdMoJx0F/sLCNPUemuQDgCwtO/OQJu/aEsB5NKJPx
	 8hSWEEv1Xm5oxEEIsO50F5igEUGZc+8XCQZXCsKU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbfHSTNc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 15:13:32 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:40833 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727957AbfHSTNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 15:13:32 -0400
Received: by mail-wr1-f52.google.com with SMTP id c3so9856704wrd.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 12:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ww1wEW2qBlY8JGlqF4b4VPopr2/Uzmff952SuXEEpWY=;
        b=QESW0rPyE0kWprypdsuq43b5yc5Evey69gIFX+0SVgRGjsehp+uAhCM5aHBxIoqiZ4
         YWroui9UCGNcTWSttRe1IqvBcheOckSSYgsfQhuQIA5TtSEiBz2jYLgmuPyPKgVGgPhT
         DpIdaJpvYFZr+9UH04FGRZrkUcVF6Kp9fJvw/ve7dJ92Va8ZtelD8FfUAdnKw1cdKTLi
         E0q1aEgqslQpKuRq4CVYZdpzNOraU4d+xFZB3KVrx26g2rFBjEP3uLZk7BKLr7gQJ9g2
         9ovl2p3Q9Vf/liiE9jBPAFXqjauG4bM+14eO6h/blxE9sVknVLeEvecQy/F+VtaklxSd
         WrKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ww1wEW2qBlY8JGlqF4b4VPopr2/Uzmff952SuXEEpWY=;
        b=gwdJnRBf/LdVl7US27huX0fXrFQlRX9YizbXNK95aqEdTojc49fBTX868VtcY4ARBJ
         qgkv4Kgtpz+5Q5hLMFiDKTGLq3+Ugjb7cKbyr8gbVBjEmY01rMiYYdGhOWI2nsszDI+i
         mXsQOI/nieNYZzAl3rljdRugeTNB0pt4CEraXDA30+2SEgxPXtomNOjvLtzkTVx+hi0I
         bXusz/2loF5vJ7ucrlFdvbRBt9LwV70dWS0fPh3reaDGoCeBaCXeSsXRl7y7bwGhK5kc
         fB9+QA55NRDnwIKCt2du11sZfU9AI3JmfKMUdDdHsQGy1NXW4R/5b7j/KpImz/y//nlt
         TnMg==
X-Gm-Message-State: APjAAAUpiduamkxmYGqh2Tzr6xLJUWaWLTTyVbM6oJQ7YxVq0HkbjKjP
        nPIsk4eXQMxLy4uIwIHJob8=
X-Google-Smtp-Source: APXvYqwDvadwO9DGcMvJoVEVLxg63jbHh0Oc9Q/kNDRRedtwxKsEqo1V8Bn5nfu0sQ+zUxCRtIQrpQ==
X-Received: by 2002:adf:fd8b:: with SMTP id d11mr27911925wrr.300.1566242009912;
        Mon, 19 Aug 2019 12:13:29 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id x20sm34421527wrg.10.2019.08.19.12.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 12:13:29 -0700 (PDT)
Date:   Mon, 19 Aug 2019 21:13:27 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [patch 42/44] posix-cpu-timers: Move state tracking to struct
 posix_cputimers
Message-ID: <20190819191327.GC68079@gmail.com>
References: <20190819143141.221906747@linutronix.de>
 <20190819143805.419809496@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819143805.419809496@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> Put it where it belongs and cleanup the ifdeffery in fork completely.

s/cleanup
 /clean up

>   * posix_cputimers - Container for posix CPU timer related data
>   * @expiries:		Earliest-expiration cache array based
> + * @timers_active:	Timers are queued.
> + * @expiry_active:	Timer expiry is active. Used for
> + *			process wide timers to avoid multiple
> + *			trying to handle expiry

'to avoid multiple trying to handle expiry'?

Should this be: 'to avoid multiple tasks trying to handle expiry'?

> +	 * Check whether posix cpu timers are active. If not the thread
> +	 * group accounting is not active either. Lockless check.

s/cpu timers
 /CPU timers

Thanks,

	Ingo
