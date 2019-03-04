Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17184C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB42420823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="Zr5qoTGL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbfCDIPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:15:34 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37648 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfCDIPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:15:34 -0500
Received: by mail-lf1-f65.google.com with SMTP id z196so2832448lff.4
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 00:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mNmnnIeJG3xfnZn5skubtzZtiYJ4Rf38aVacWRwjVpQ=;
        b=Zr5qoTGLKr/FIbRZ17BTRuJxy9aJ9Y3jwEd8R0UjshxYxW2NUNETe545WXHN4DDQ1O
         +c2J2Tz9R3fhmWhyusyWp0Y5+i3IraWR9HKDzg6kku9yTJ7oHML8UzLm5rJaRodc5oBh
         yVkaA1Z7Kt8RpT7xNmIhZHfi0YUsYbdcisA/9kYa7eIK+IFcrf0kcZAJFPO7pTE1oVdp
         k9kd29ElbTX9b3zXSw0aXdWOXlR4uTke0NjE/TxSe4niggfOmYQv2PRlbf1duwT2uREB
         8DUY/FWTJa6zHnF/NKKqbOmQQ3w68I9AMLSZJPJyK8/HFQXttDzEQKxZz13dTB5IjCS+
         me3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mNmnnIeJG3xfnZn5skubtzZtiYJ4Rf38aVacWRwjVpQ=;
        b=ZplB5tzcNeAQG98BlpHzKjS7owvMTOTQW3CftN34x+JQAWSG/tsIheZFlFyGOLT5vm
         4YfcrmMa8hzKc1Csof0cjgw9pY5A35vpchpKqfEB1yFJpfQe7jq5grozkvSmavEW7Lfj
         Nb3zpGSQnDkMByxBbDMdn91G0q4zc3Blrc7o7ny9+cGPWe0Tjj7bZFXNLY+PoKo1wqQ/
         cpx+LYf0m601rxp4P8qOBEMJP+tSumoECCAlXrfE+kcuKsO3eHmhUkEl0WfTKRJoh6/r
         uNNcJkNopN+D597O1IOKT4eRSJynjMeQ8giJKmtwfoJdTHcvfMbkPhiXRouUKQEVjS/p
         PHoA==
X-Gm-Message-State: APjAAAWR34g03zlFGL5z7Brj2IHkSozoF93W7D94R995bOZpGZNIKA4m
        ZNypDakSe04yV6T088VhYVsSew==
X-Google-Smtp-Source: APXvYqxVzVo2K+PmJ2+i11jwHsM0a+bg5DuXuqVLIIrMjzYBcS/cQ3QUAYADgMR+sQs9+6s731j5Aw==
X-Received: by 2002:a19:ee11:: with SMTP id g17mr9539545lfb.7.1551687331937;
        Mon, 04 Mar 2019 00:15:31 -0800 (PST)
Received: from kshutemo-mobl1.localdomain (mm-159-97-122-178.mgts.dynamic.pppoe.byfly.by. [178.122.97.159])
        by smtp.gmail.com with ESMTPSA id b19sm1384590lfg.56.2019.03.04.00.15.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 00:15:31 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id D9EA33007CD; Mon,  4 Mar 2019 11:15:29 +0300 (+03)
Date:   Mon, 4 Mar 2019 11:15:29 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, keescook@chromium.org, thgarnie@google.com
Subject: Re: [PATCH v2 0/2] x86/mm/KASLR: Change the granularity of
 randomization to PUD size in 5-level
Message-ID: <20190304081529.nuneutcjhoa56fw7@kshutemo-mobl1>
References: <20190228003522.9957-1-bhe@redhat.com>
 <20190228091001.5wvkwe7cqkf2euzc@kshutemo-mobl1>
 <20190228092346.GQ14858@MiWiFi-R3L-srv>
 <20190228095503.jy44nwqhtmr4qeaq@kshutemo-mobl1>
 <20190228100419.GS14858@MiWiFi-R3L-srv>
 <20190228103051.dvqiy2slwwt56ag2@kshutemo-mobl1>
 <20190301144502.GV14858@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190301144502.GV14858@MiWiFi-R3L-srv>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 10:45:02PM +0800, Baoquan He wrote:
> Hi Kirill,
> 
> I updated patch per your comments. While I kept the 'paddr' variable and
> the '0' initilization stuffs. My thought is there are two kinds of mapping
> in the handling, so keeping these names from old codes can make it more
> understandable. What do you think?
> 
> Kind               Physical address            Virtual address
> ----------------------------------------------------------------
> Direct mapping     paddr                vaddr = paddr+PAGE_OFFSET
> 1:1 mapping        paddr                    paddr

I agree with your logic and patch looks good to me. But maybe you should
exmplain this in the comments too?

Anyway:

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
