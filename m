Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3CBEC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 10:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C920020637
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 10:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dAk2F7mz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbfKZKuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 05:50:35 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51264 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727682AbfKZKuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 05:50:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574765433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=R0suUB0h2cJm9IG+wl8vuFejSumo0ekP4tj9lnnUJew=;
        b=dAk2F7mzkUTnJG/SqgL0F9APFnt/4jQfkopFB9tnAWvtzaxGJSf1x0VYkNeQIkvXtU21BI
        8Syde8EqBmWehuZgotu8qaZFuocardokGapkhxgA8O80hDj9AMUpP0jXywnoUIpV87+mzt
        h9wilDpglzGJPk1PZMl73leqRmWn7jo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-MZk8Y8-6OzOtxr-UYBa_3w-1; Tue, 26 Nov 2019 05:50:32 -0500
Received: by mail-wm1-f69.google.com with SMTP id m68so1010855wme.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 02:50:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R0suUB0h2cJm9IG+wl8vuFejSumo0ekP4tj9lnnUJew=;
        b=kwaOaPOC0GLpaTjszc0SOxsOnfUcFML4FMsM3m/IHXrPgrWD2mN200n+SouJXMlKbZ
         Ih93LCEySbBClNoOxHftE8LKIM1pNtCUs1ZMm022xF3MBEz4uqacDeuOu37JOgNWG2cj
         t5seqpgROo0bEIfY35aLhbR6ADTyUPJMp4elIVGQbFB4jEqwq5bTIHQEILD7Fb+PdW8s
         vnNuPrqfv4ZB2YUBZcgHC+KbN9jQjRVyTylOTbo48BWA2JMn8OEIQgjSA8so3Mf6RGT/
         og9QdrLMvepsHvRU41eL2Gknejd/pV+FoYdLt16/EuRUGK1Kj0pivaLe0GzDPQDXvF5G
         sBqA==
X-Gm-Message-State: APjAAAXK0YM40L13n46yeR1L7Yz4QHRW0ViVHLdUE0lqyilDCyq2VBP9
        hTqZbTZtGdxX0dKCoFP7xAk1H8NxYoWjP8QY1IPHmu7KBowHJH4GM7cM7E6Fuj018MIaplF8Ve4
        xkRjaXFkWSMRtup2kpsYBduEK
X-Received: by 2002:adf:d091:: with SMTP id y17mr38095418wrh.182.1574765431443;
        Tue, 26 Nov 2019 02:50:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqxYWtiHjTbs2+gq5fix9nXS12FIn2I1K/paROsrcbJEox1XXKa4zTvdRRqUsp5+Wm4plu4R0A==
X-Received: by 2002:adf:d091:: with SMTP id y17mr38095394wrh.182.1574765431153;
        Tue, 26 Nov 2019 02:50:31 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:5454:a592:5a0a:75c? ([2001:b07:6468:f312:5454:a592:5a0a:75c])
        by smtp.gmail.com with ESMTPSA id w11sm15560411wra.83.2019.11.26.02.50.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2019 02:50:30 -0800 (PST)
Subject: Re: "statsfs" API design
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     KVM list <kvm@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Peter Feiner <pfeiner@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <5d6cdcb1-d8ad-7ae6-7351-3544e2fa366d@redhat.com>
 <20191109154952.GA1365674@kroah.com>
 <cb52053e-eac0-cbb9-1633-646c7f71b8b3@redhat.com>
 <20191126100948.GB1416107@kroah.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <75dc4403-cc07-0f99-00ec-86f61092fff9@redhat.com>
Date:   Tue, 26 Nov 2019 11:50:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191126100948.GB1416107@kroah.com>
Content-Language: en-US
X-MC-Unique: MZk8Y8-6OzOtxr-UYBa_3w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/11/19 11:09, Greg Kroah-Hartman wrote:
> So I think there are two different things here:
> 	- a simple data structure for in-kernel users of statistics
> 	- a way to export statistics to userspace
> 
> Now if they both can be solved with the same "solution", wonderful!  But
> don't think that you have to do both of these at the same time.
> 
> Which one are you trying to solve here, I can't figure it out.  Is it
> the second one?

I already have the second in KVM using debugfs, but that's not good.  So
I want to do:

- a simple data structure for in-kernel *publishers* of statistics

- a sysfs-based interface to export it to userspace, which looks a lot
like KVM's debugfs-based statistics.

What we don't have to do at the same time, is a new interface to
userspace, one that is more efficient while keeping the self-describing
property that we agree is needed.  That is also planned, but would come
later.

Paolo

