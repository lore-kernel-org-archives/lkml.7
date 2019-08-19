Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D5C7C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 20:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8E89206C1
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 20:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566245408;
	bh=6V4JxJx3veBe8C9TI1555TcrPmK8bZM4x4joVkqa0ho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Wpfr4fsCiKs3ZuHoF1jC8Xf793VeO0ZQqm+vx8wEuN/pcvVT9T96dN8+SLh8Q/rmu
	 GK+w21Yv/HkeINSicyyOlq63kl1HQ/Ct+bEh8tnAVFHafW9vnyTkXHFxPdddXe4gXp
	 MSLxuRp1aZODGEKnXw1NCFxk1TyK4PTTw29An4Os=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbfHSUKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 16:10:08 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:42824 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727925AbfHSUKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 16:10:07 -0400
Received: by mail-wr1-f43.google.com with SMTP id b16so9993188wrq.9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 13:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WOo2/3Szgh6rMOzzylGcdENFKWQlCnrZVahnfLHooes=;
        b=vBU8gbDjLqV2lcZ2mBwva3Ja6u55FIUc4y0rRT8XplIZmQOYW1g4dhA0CXAHnVXEGh
         8ApWin9pSphOs5IIATitxv+UqgsFfS6s2/0GjQhlrW0B0kFGowOeYvDnKAYg8sm1fejm
         5G+3DptDQDuayVmQ+0AGtX5Nsh+lmGI3BA9mPlM5WDGwdU0uiriB9wiqAHLr8Sd2Ft12
         XDtCSlaCrM+7+Zi6aAlbVeSw7jcE1ZLFETLt5PGUyXSKV0eSDK1Wv4mjmfQrC0EJu/6a
         ZPEFZzoeAqO07NITHTVlYVQlW2Ps3MdISlVEelNY71IOUxPQn/EzV6j3UB2unhQcsLOM
         nqhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=WOo2/3Szgh6rMOzzylGcdENFKWQlCnrZVahnfLHooes=;
        b=r2nYrzHKva8Djg47tmtqExid2wdvoC43wR6fMrnZ8giTOEQNeNOrCKB6H5qpHJN9oL
         d3ZL23x46tER1sTRrC9OVlvvj/5Ynq2z6FiBkfEQ9IGwSButFH+C4RfOKKw3drXtz+m6
         th3xxSEl/cZCtYIe3mRUr72l8//2UiGycV2XyyrGqhzr1ovjW2v50FCvJP/UCS2yz5Ut
         5jR1VSj09Fz6mOOruTd5VvPGDSTqNQTqt7sEW8JIrOW+67/IpzlZH+M/oU4DyGhJjep0
         temR+yJSeV9XLsKzy6ut1G0PTp71sQii0zAHfgYSgj4p4OSNzJDFuD9fs7I/suoW5XhT
         QJ/A==
X-Gm-Message-State: APjAAAXLJhhJRZXIqs9R2ZhdHJBaiqMIXfNsmLApNj9X4/qW3esdrFoj
        2wysL/dTRXeCgJjyYbbBSSg=
X-Google-Smtp-Source: APXvYqzhJ9+ITUKdWyiGqiXnx2vX8tMcX6QkKn7UkG2A2jN354kmdsD436ZfNmU9SyQrR7nSbdHZ8g==
X-Received: by 2002:a5d:6307:: with SMTP id i7mr30131004wru.144.1566245405669;
        Mon, 19 Aug 2019 13:10:05 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id j20sm37757994wre.65.2019.08.19.13.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 13:10:05 -0700 (PDT)
Date:   Mon, 19 Aug 2019 22:10:03 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [patch 40/44] posix-cpu-timers: Remove pointless comparisions
Message-ID: <20190819201003.GF68079@gmail.com>
References: <20190819143141.221906747@linutronix.de>
 <20190819143805.221910859@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819143805.221910859@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


title:

s/comparisions
 /comparisons

Thanks,

	Ingo
