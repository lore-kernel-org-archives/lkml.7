Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 758E7C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41C4A20833
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554802258;
	bh=xF0MHbJVnFRkXMVSY0Sz0OcFAfptosSeLujRNokzuKU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=UB59A302JrQ12CbQ8N24CsjeYG+XKGDxH4oKIzyVs9dcGOgawaMZs4f3M9D2D7LUk
	 zO0EFrPTHQTC83JxxbQ50rsSZZFWAwWjWdE5oYSXbvW+kOGBVbi4q5rXwvLWS8KIWx
	 d56nEQRmeVFkRhTpGZ6D3zdSdk2T9kOjvPu8Xd8Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbfDIJa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 05:30:56 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37425 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbfDIJa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 05:30:56 -0400
Received: by mail-ot1-f68.google.com with SMTP id c16so14937214otn.4;
        Tue, 09 Apr 2019 02:30:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xF0MHbJVnFRkXMVSY0Sz0OcFAfptosSeLujRNokzuKU=;
        b=Yx+XcIgoPC7vYMCffgiBnHarZgO8Xg2Z0nnK3YFHYh32TUNW5aBG9t0bipX5gAIAMm
         Xk1fyV2MzJ7XUas5BxYSorqo/JMYvKsqU0m4OX6WSZarFSeDijcjN0sNp5MbRZPra10R
         JOwN3/vCJ4dLartraKLQ4IzWAjWJB0LvIvvmcSDyJgX+1U9cQF9wac5XSdxVzSXtDJ10
         8wFw1Y+7B6edl1aKTNXADDA3ElYxi0UnanpEvJIEiXWI1deAkU+IVfPm6I42orukaruv
         CE2g8ui/vk6TNpJtVBzhDjjeRTn7dT8DPZ1t/9Z40+vEwQEaOwZH6IDYQcLB99ih8nOD
         H+cw==
X-Gm-Message-State: APjAAAXnNb/OztPaW1xdAPXAGg/oWH/q2F2sWVNTmo/oJk5P7SHcERGA
        dlX9YqSD3pyrdENpjAQju2QXwamdmVVTQZjdFyw=
X-Google-Smtp-Source: APXvYqy2whJeRDYFhQ1WR8epZJWXwBAbpl0SMfSDW3+AyfZoBtTVvs/WROgMZn7JgUsV/JmPbpgj6GGcqBKPhykhhEs=
X-Received: by 2002:a9d:2dea:: with SMTP id g97mr3637022otb.20.1554802255792;
 Tue, 09 Apr 2019 02:30:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190405091647.4169-1-huntbag@linux.vnet.ibm.com>
 <20190405091647.4169-2-huntbag@linux.vnet.ibm.com> <87r2acwpp2.fsf@dja-thinkpad.axtens.net>
 <a8368cfa-9667-5f5b-cafe-f4830ece0f26@linux.vnet.ibm.com>
In-Reply-To: <a8368cfa-9667-5f5b-cafe-f4830ece0f26@linux.vnet.ibm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 9 Apr 2019 11:30:44 +0200
Message-ID: <CAJZ5v0jS7HX3ka59OhYzbdgdAYDO_DTwp44gxar_xQV_AsscSw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] cpuidle : auto-promotion for cpuidle states
To:     Abhishek <huntbag@linux.vnet.ibm.com>
Cc:     Daniel Axtens <dja@axtens.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 9, 2019 at 11:29 AM Abhishek <huntbag@linux.vnet.ibm.com> wrote:
>
> Hi Daniel,
>
> Thanks for such a descriptive review. I will include all the suggestions
> made in my next iteration.

Please give me some time to send comments before that.
