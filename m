Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DA1C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 23:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D27F120880
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 23:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bF7riyWn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730868AbfDPXwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 19:52:10 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39734 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728856AbfDPXwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 19:52:10 -0400
Received: by mail-oi1-f196.google.com with SMTP id n187so18533166oih.6;
        Tue, 16 Apr 2019 16:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SYeYDryOK3yT496e/CvY056xlE32b0Qxk8TqJQ2hcLA=;
        b=bF7riyWndsWivzD6c8hxIus4/h473DSK3CghRnP+/upx7dEm/XhNKa8zNsAgCUHQxC
         d7+eiJp5g6yDCPe377L7aAguz+RaTC56Kv+a3PbM5oVW4IlunOePVUIQ9nbjCRu58QRe
         3ulM4amXAycHz70UtDfQ8HihRZJmGeDpN7gSmcj8HTWho9M0hQE+2NmP+8j40yi1pAGi
         zc6g/CsTXQwQWRTDTcLauETPzzNfn/zGkUK5fVdiuG6k/rk7s6LBystWp9TxbZcAdgk1
         FHa/vDlsfDV+uDPtbFjMUqTNMkh5YOj38Z4DwKF5w+rllyZVxKUIegcSiI8UsqgB5Tzg
         0YpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SYeYDryOK3yT496e/CvY056xlE32b0Qxk8TqJQ2hcLA=;
        b=jiEvOhkSonl/D/AhXp0A87uyg37+kgUA1l5Nme2CufpmGHch99z3YjrooWeZMs4RF0
         JWc0Hm0xyAYvNCT6KuR09X3MUDwJn2ypiK2EzJYlYJfIDqTflh9ZZbabq55asmL07h5f
         3K9sqp5hgaYmxjZTz9RF0J1oqMl9RGUQWjdN+Sn4sMwlVkyI6NTehtF+8kttsRrTij1U
         AVRhwjCKMD1S9PffXcqgcSmjhs2O7ovyjy/pUxcNhUoJ/fZKBmAknsg50Di5VyrTRDua
         syVn/iA4+0J74NlLX2Np1ZsEVfbejMu5eZ3nnhM5/d+Ih7dRvN6AQNp1FB4/gv6SD7NZ
         Y53w==
X-Gm-Message-State: APjAAAXqt0lv5mZpX/SnaqJiDUX8y/cJwYSgh4CWQY6XxVf0+IKozTrQ
        cReR7QaHl9vTnmcJENAKJqM=
X-Google-Smtp-Source: APXvYqz6xAlLle5ecFbDA/5QkfWhmlBSWpNfNDiqJI+iGA9o7nWtiQDV7KuFqwb4qcOeIkrtNcHE8Q==
X-Received: by 2002:aca:af49:: with SMTP id y70mr23543635oie.168.1555458729615;
        Tue, 16 Apr 2019 16:52:09 -0700 (PDT)
Received: from [192.168.1.2] (ip68-101-123-102.oc.oc.cox.net. [68.101.123.102])
        by smtp.googlemail.com with ESMTPSA id h23sm24795458oic.10.2019.04.16.16.52.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 16:52:08 -0700 (PDT)
Subject: Re: [PATCH v3 net-next 09/24] net: dsa: b53: Let DSA handle
 mismatched VLAN filtering settings
To:     Vladimir Oltean <olteanv@gmail.com>, vivien.didelot@gmail.com,
        andrew@lunn.ch, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        georg.waibel@sensor-technik.de
References: <20190413012822.30931-1-olteanv@gmail.com>
 <20190413012822.30931-10-olteanv@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <b262a8b5-44cf-7e7d-f812-c1c605ce8b43@gmail.com>
Date:   Tue, 16 Apr 2019 16:52:06 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190413012822.30931-10-olteanv@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/04/2019 18:28, Vladimir Oltean wrote:
> The DSA core is now able to do this check prior to calling the
> .port_vlan_filtering callback, so tell it that VLAN filtering is global
> for this particular hardware.
> 
> Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
> Suggested-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
