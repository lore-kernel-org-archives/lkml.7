Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69EFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F68420643
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552324830;
	bh=fgGNakfBqklm2voVcan2RrmUTxWPEE/C5uBrax3Xebc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=QudjAi9odWbMR8PshcjYQbWU5p5JeQRf53JwOng14uxW0tUiI5QdJjz0MKXuezOHO
	 l82mRG/vqF8WlKt3uAV4zqDjhhDjblh5ZZ5NZdp8Pe4/yD0BE65BzviFzpjT2uCpmq
	 uP8NivFof+LYl/EOMKE6vgr2bVv61/Bi7YhTtXfk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbfCKRU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 13:20:29 -0400
Received: from mail-lj1-f175.google.com ([209.85.208.175]:34576 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726625AbfCKRU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 13:20:28 -0400
Received: by mail-lj1-f175.google.com with SMTP id l5so4817848lje.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 10:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZPaMqMUDKbBMxJ/g5yV7DXcRIsUIZsug2nVYeoG/WKg=;
        b=V/ZOWav7FOCBvpMRVQfRlyepy+ZlZ35SOzV0/5ae4a8mZmdYi/SBKUgrFVL7E6KvNg
         pLzwpVRT7/jpJKHTG6LKj0qHVQkoE3H63WAXZ8fBe9gsekmEBqPq2v8NfJJfWaL9p5Ul
         vE0+/TYzqN5oyegFGFghOITyIRKbAXG1ENZWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZPaMqMUDKbBMxJ/g5yV7DXcRIsUIZsug2nVYeoG/WKg=;
        b=BsgAQK+vPsdsBLJ4T5EL07z+5wDotkc5luHRf07k/m3yuJBs5mK65T7+q5+duMFGRI
         gP7nYAcStd2aalhvqpxFtTQTqE03IEfz/yFar6N452Bkd5JNz7Fs+iD07HMFoyxgdWGo
         s4QwTCxfSDmwNSIjtndU6wIlbtAYbs4nSCjwh/tCDfV7/ZN6OXdfIccOTxFG6UfKWDNU
         S0Z9oh+L2LOgTfVBGNF5gec64wOirYq46tE8DxZet8V6d3RBxrJtOhTCVY3JzRv+TT5V
         WV/kgyP9aNvTKZmobq+fN0gPVeVOw+UHPAZ5QiQwm4I5cei7lMlzdPGbVQ3JeTSLluXl
         Q+7A==
X-Gm-Message-State: APjAAAWRkJ0G1Sc2FMJm+2+636uaDImXsZ9MOhueQBhW4cJcxZWK0F2c
        T0k1GM0US1Zp0nb7lf7LlcJ05QhQxec=
X-Google-Smtp-Source: APXvYqyT7vGPI5VeVaIoKKYlj3SRJZ65fS0yp4j50D9G+faasz2QHsV7ecDtQS1ez3pggjIDenVf+Q==
X-Received: by 2002:a2e:4d7:: with SMTP id a84mr16987322ljf.86.1552324825044;
        Mon, 11 Mar 2019 10:20:25 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id o12sm1032821ljc.37.2019.03.11.10.20.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 10:20:24 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id q128so4786094ljb.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 10:20:23 -0700 (PDT)
X-Received: by 2002:a2e:7a03:: with SMTP id v3mr17349930ljc.22.1552324823218;
 Mon, 11 Mar 2019 10:20:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190311074315.GD10839@shao2-debian>
In-Reply-To: <20190311074315.GD10839@shao2-debian>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 Mar 2019 10:20:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj2TzOJqCr0-J5H6w=d5DgAtVQBQNrYHzaTMkEwkZrwnA@mail.gmail.com>
Message-ID: <CAHk-=wj2TzOJqCr0-J5H6w=d5DgAtVQBQNrYHzaTMkEwkZrwnA@mail.gmail.com>
Subject: Re: [LKP] [selftests/vm] a05ef00c97: kernel_selftests.vm.vmalloc_stability_smoke_test.fail
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>, Shuah Khan <shuah@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@01.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 12:43 AM kernel test robot
<rong.a.chen@intel.com> wrote:
>
> ./run_vmtests: line 217: ./test_vmalloc.sh: Permission denied

I marked that script executable:

  6bc3fe8e7e17 ("tools: mark 'test_vmalloc.sh' executable")

although perhaps the better fix would have been to explicitly use the
shell to start it in the 'run_vmtests' script instead?

We have a lot of files that aren't marked executable, probably because
they came in as (or were generated as) non-git patches. Often through
Andrew's workflow.

But most of them don't seem to matter, because they get run using
explicit script engines. So I only fixed up this one case.

             Linus
