Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C9BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AA8D2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWhgh3XB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732371AbfCZR5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 13:57:47 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44387 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731761AbfCZR5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 13:57:47 -0400
Received: by mail-pf1-f195.google.com with SMTP id y13so2299201pfm.11;
        Tue, 26 Mar 2019 10:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uIMzZO448XjjTawJjM9yVh4huNStHeJLMhciG92y8OE=;
        b=BWhgh3XBCNVNaFRTkEGTmzqoLVYq9yPKUVIseY03oge4ov6pyFJSBDkCwQ8AA9lyIr
         XcdBZvZvGOl/tDFaXbfljwh7rruEpJOOtyNmsqvEgWXhKJY0s6drIUl9qRSfECJz5sM/
         aOUp9R12/hwRcJrZkP2tiw6O/U/FBfoY2UT72S/Fz2m8Rn+s7i6lGZuvaFVxAXGJNboI
         nkWh1ikuDbtPdmo+0HRrRMwpXBd0mH+ZRF4HCURIx+qWgHnAT09MBVk9OPT+uMj1dfYp
         K5imcLlNISLSYjqkkhBSMgbpTJwMH+T/hDHiWAXIpR9EQSkdrT8iGsXvATH54cfQQiss
         R7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uIMzZO448XjjTawJjM9yVh4huNStHeJLMhciG92y8OE=;
        b=VDr3kfhlm6uZDTU2c4SgTiWifBWK+CFWuvzfKdxtQM1mjPJqYPfu3RYcLEGItIFXDg
         bWIVWJn273J6hAJ7NkY+6XSIfZjHpH25ReNmw9Am/ug7m9m+cgiz2NVvhHSo1fQj7HiJ
         Wq6AfK1JECoIFf7ezUu1albBX+FG03Ry8inYQ1j4tCQnzjumwuS8/4j/hdDyg4MjNKcY
         Ltl8/ItjWPSXNbcvOQA2Q5jHQpWJAWXIJBlk8RJ3yi/OsXVrGmJiJ5CIUId8Jd1v+2d4
         jj/2NbiW1kRQ2DWvLNm2RPPxcBktif0IrimYl+KlnNPbGK6xjD8nV4OAgtHUrv9cKf2n
         QDsQ==
X-Gm-Message-State: APjAAAUjlTkHTHvJatR/BJ8os99RwGYyxM5SQHtfrclqva53ZmvWHJPG
        MLIMckep64C62U/77ZchdIULj47O
X-Google-Smtp-Source: APXvYqwCLwttCvmaVZOo3x5lqWoIGIeMJkVWNK+TOKbks626/797wt6ZkhBGQROMcP+j5rvRz3+qvA==
X-Received: by 2002:a63:ad4b:: with SMTP id y11mr16453978pgo.405.1553623066085;
        Tue, 26 Mar 2019 10:57:46 -0700 (PDT)
Received: from ?IPv6:2601:282:800:fd80:68e1:6a44:f6ee:46a4? ([2601:282:800:fd80:68e1:6a44:f6ee:46a4])
        by smtp.googlemail.com with ESMTPSA id v15sm10324267pff.105.2019.03.26.10.57.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 10:57:44 -0700 (PDT)
Subject: Re: [RFC 4/4] net/ipv4/fib: Don't synchronise_rcu() every 512Kb
To:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org
Cc:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Ido Schimmel <idosch@mellanox.com>, netdev@vger.kernel.org
References: <20190326153026.24493-1-dima@arista.com>
 <20190326153026.24493-5-dima@arista.com>
 <2f911647-f35f-13c2-8177-2fb93147b0fa@gmail.com>
 <bd638730-e23a-3d08-bd35-9c80af13692b@arista.com>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <dff0e80c-fa15-c28b-b34f-d80f59162051@gmail.com>
Date:   Tue, 26 Mar 2019 11:57:42 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <bd638730-e23a-3d08-bd35-9c80af13692b@arista.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/26/19 11:15 AM, Dmitry Safonov wrote:
> I still wonder if it's good to expose it to userspace rather than
> shrinker, but this probably should work for me - I'll test it in near days.

I did not know about the shrinker, so can not comment if it is better or
not. If so, my patch can always be reverted since it was just applied.
