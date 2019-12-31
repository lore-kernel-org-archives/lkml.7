Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8232C2D0C3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 01:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86F2C206DB
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 01:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20150623.gappssmtp.com header.i=@landley-net.20150623.gappssmtp.com header.b="gkbBODTm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbfLaBmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 20:42:04 -0500
Received: from mail-ot1-f44.google.com ([209.85.210.44]:33915 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbfLaBmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 20:42:04 -0500
Received: by mail-ot1-f44.google.com with SMTP id a15so48479865otf.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Dec 2019 17:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=IhAfzThJwAWoHfkM+UxA4QU4Nemt1e8eu+lMjgHEYCE=;
        b=gkbBODTmsz0kUSgWYluEP+MA6pj6n88wJ3WzHLSyxRsO6iXKCeZzfKDTwXuwfLprda
         qMjjNzCSzdsKfwL7TpXzEti5FP+g7efKOKq/OEtJRZFk0/eqEyTkQYSR38xy7eJ0jE4B
         aGq45mSlHgz6CaeYNPG8hS8tnezr0W0TuFV4fg/U1zFV8yOiFZDAehvq/T0Z35JvgVTY
         gWBhmaNhmbU7zOWjrVD0DFgTpRUrCIx5wyhvslTmqBRj+QdGL1F9Y8UmDnkA0y6Kf6FI
         1z01Yhbh+o6frX8gPWLQS0Waib7Z1HmOmN9dTpUwDNAKCL/1kAjSxtMo058Hxwav27nF
         Xr9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IhAfzThJwAWoHfkM+UxA4QU4Nemt1e8eu+lMjgHEYCE=;
        b=P+wtxzlbl2ZmzwwoWzFeWX5tJ7IYqxuHFEf+MofzFz47Bqx7NaOuoIrLpQu0zmcuGr
         wkyspgn61P0mibJ2OyxoZ4RilIpMcjp7d2T2nSkbSUe1ZK5oTYMmVaJPdNyHPBaZpoqA
         VfWA8Xaz7rQ8xl37xfSnxYBAtUTDtqzNRL7RNKnhJX2/Qhe6XdfnnLmUm1kP8oUYQOeD
         f6aByVeYKQ7qioW0mASwNU9zUL8qKKemSdq4rIPvQcy61tE+Ieio8OGk30BjfRrVAC88
         H/e8d7F4iptfnUsqHrnnBegsNx2eP/RN8lcwaq8AX1fc49GM6uhfc1WG26aFVocCdXrD
         TjJw==
X-Gm-Message-State: APjAAAUz2LtSjbW+SiXXQpnXhY/0E5eSbdl3oJSzhEwUiDxGSsfKZfPO
        3kE/ovl6CLoG2unW8nZxyt+NIzlengY=
X-Google-Smtp-Source: APXvYqxru8Mz9u2k37V6hbyUKoaldU/MWdmWTSBKR+NW4vivCxcklNBTa9MO5TuP+XMiqvxZ9SJ8aw==
X-Received: by 2002:a05:6830:13d3:: with SMTP id e19mr68854336otq.135.1577756523077;
        Mon, 30 Dec 2019 17:42:03 -0800 (PST)
Received: from ?IPv6:2605:6000:e947:6500:6680:99ff:fe6f:cb54? ([2605:6000:e947:6500:6680:99ff:fe6f:cb54])
        by smtp.googlemail.com with ESMTPSA id s83sm14367185oif.33.2019.12.30.17.42.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Dec 2019 17:42:02 -0800 (PST)
Subject: Re: Why is CONFIG_VT forced on?
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
References: <9b79fb95-f20c-f299-f568-0ffb60305f04@landley.net>
 <b3cf8faf-ef04-2f55-3ccb-772e18a57d7b@infradead.org>
 <ac0e5b3b-6e70-6ab0-0c7f-43175b73058f@landley.net>
 <e55624fa-7112-1733-8ddd-032b134da737@infradead.org>
From:   Rob Landley <rob@landley.net>
Message-ID: <018540ef-0327-78dc-ea5c-a43318f1f640@landley.net>
Date:   Mon, 30 Dec 2019 19:45:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <e55624fa-7112-1733-8ddd-032b134da737@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/30/19 6:59 PM, Randy Dunlap wrote:
> #
> # Character devices
> #
> CONFIG_TTY=y
> # CONFIG_VT is not set
> 
> But first you must set/enable EXPERT.  See the bool prompt.

Wait, the if doesn't _disable_ the symbol? It disables _editability_ of the
symbol, but the symbol can still be on (and displayed) when the if is false?
(Why would...)

Ok. Thanks for pointing that out. Any idea why the menuconfig help text has no
mention of this?

Rob
