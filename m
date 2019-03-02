Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A964BC00319
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 23:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7908B2086D
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 23:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Abrpzevq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbfCBXSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 18:18:02 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44516 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbfCBXSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 18:18:01 -0500
Received: by mail-lf1-f67.google.com with SMTP id v185so968620lfa.11;
        Sat, 02 Mar 2019 15:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M7jIS//rCFk++6S+n9FbGOLmMxyBmtUuiNkz8k3ERNI=;
        b=Abrpzevqkb0f+/AfOwX1FxtVnrpAd7vCQKTtSelCMFhfXLNXnAZefAF7mOmwZFb84c
         dbSafENlxohFXAh6RoMlCQt49domF5Ms0w4ymUiIZlmEXa0hTLBQlTs+mK/IJ8UKNlTD
         USkBDlxmcGXRIlIomBUf7QNt8fXe2TW0CY7irBDXLvsbW75yp6BSUGxAgQIk8s4Hj39n
         F9YQkF0M3ACP4YXX0vFs7ODVPyV1VoG/UqqRB0FtK+rUiSI120+PDnhTGMwA9eKUxyAl
         xzLhV/yAuh18svDbV9NvkOFwg9PD9gR8QNTChbTMWOe6MOSWQfwwzqPmyZVkktkvOuNY
         MKLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=M7jIS//rCFk++6S+n9FbGOLmMxyBmtUuiNkz8k3ERNI=;
        b=n55t0ccYJATg264+08yRZo/Apsj6gSY/DXreVr9iKp9dDGLo44pocMecqqDYU+l5IP
         en5vvE4+v5eYsMxhPsdbsIBDa+ddpE07p725+XRFydG01YqgwoLZ2k66xx/ODKQ1N14O
         YZQnH14aBp8WT8w9SbNFni/1m0UmVjTaqNMaOo8XBtJvHEIJRPlWUWY8rhD6GG4HJTYo
         xjoHf+/ovH8YHB3C609fMRPQAMd0iVAa0pBddDWmqvd0Hlx0I7W27BhX2KIa1h1UgdlB
         N49KTNQ2zDWciEfMENAwW/EgkgKfzVW33iRQd89m8OMvtSTBED0lY8u7UiRnH5DgghI8
         ejrw==
X-Gm-Message-State: APjAAAUGDWIj4kQI8aSgnbxXHCv+5CpPMh31lIQO9M7MgfC4eXUx79jw
        UwzMSJey07GghzDUl3XGs30=
X-Google-Smtp-Source: APXvYqzX0w0gGNIoaN5r2Je2RIeO1xfxUP7vRlgff8XaAFZ5njf+j9zUvLs/R8QkkUE9lF2TPAhP+w==
X-Received: by 2002:ac2:559b:: with SMTP id v27mr6477439lfg.164.1551568678202;
        Sat, 02 Mar 2019 15:17:58 -0800 (PST)
Received: from ?IPv6:2a02:aa7:4000:561e:3eff:d48d:3612:5c09? ([2a02:aa7:4000:561e:3eff:d48d:3612:5c09])
        by smtp.gmail.com with ESMTPSA id m16sm481575ljb.50.2019.03.02.15.17.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Mar 2019 15:17:57 -0800 (PST)
Subject: Re: [PATCH] net/bluetooth: Fix bound check in event handling
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller@googlegroups.com
References: <20190228195939.30685-1-tomasbortoli@gmail.com>
 <8F6AC5BF-F50B-4C30-A73B-98526AF181EB@holtmann.org>
From:   Tomas Bortoli <tomasbortoli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=tomasbortoli@gmail.com; prefer-encrypt=mutual; keydata=
 mQINBFpCTZMBEADNZ1+Ibh0Z4pgGRcd1aOUMbe/YfHktmajjcoTnKmZZunjoUVAl8waeLITd
 BC2c8i1wHzHcnthrmb1izs5XlG6PZnl8n5tjysSNbwggzS1NcEK1qgn5VjNlHQ5aRMUwCC51
 kicBiNmlQk2UuzzWwdheRGnaf+O1MNhC0GBeEDKQAL5obOU92pzflv6wWNACr+lHxdnpyies
 mOnRMjH16NjuTkrGbEmJe+MKp0qbjvR3R/dmFC1wczniRMQmV5w3MZ/N9wRappE+Atc1fOM+
 wP7AWNuPvrKg4bN5uqKZLDFH7OFpxvjgVdWM40n0cQfqElWY9as+228Sltdd1XyHtUWRF2VW
 O1l5L0kX0+7+B5k/fpLhXqD3Z7DK7wRXpXmY59pofk7aFdcN97ZK+r6R7mqrwX4W9IpsPhkT
 kUyg3/Dx/khBZlJKFoUP325/hoH684bSiPEBroel9alB7gTq2ueoFwy6R3q5CMUw3D+CZWHA
 3xllu46TRQ/Vt2g0cIHQNPoye2OWYFJ6kSEvaLpymjNDJ9ph2EuHegonDfOaYSq34ic2BcdB
 JkCgXRLP5K7KtRNJqqR+DM8xByeGmQv9yp6S97el+SiM9R53RhHawJZGz0EPl+2Q6+5mgh3u
 wXOlkmGrrSrlB8lc567l34ECl6NFtUPIL7H5vppIXAFl7JZUdQARAQABtB50b21hcyA8dG9t
 YXNib3J0b2xpQGdtYWlsLmNvbT6JAlQEEwEIAD4WIQSKOZIcNF9TdAG6W8ARUi5Y8x1zLgUC
 WkJNkwIbIwUJCWYBgAULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRARUi5Y8x1zLvCXD/9h
 iaZWJ6bC6jHHPGDMknFdbpNnB5w1hBivu9KwAm4LyEI+taWhmUg5WUNO1CmDa2WGSUSTk9lo
 uq7gH8Y7zwGrYOEDVuldjRjPFR/1yW2JdAmbwzcYkVU0ZUhyo2XzgFjsnv3vJGHk/afEopce
 U6mOc2BsGDpo2izVTE/HVaiLE9jyKQF6Riy04QBRAvxbDvx1rl26GIxVI6coBFf4SZhZOnc0
 dzsip0/xaSRRIMG0d75weezIG49qK3IHyw2Fw5pEFY8tP0JJVxtrq2MZw+n4WmW9BVD/oCd/
 b0JZ4volQbOFmdLzcAi2w7DMcKVkW11I1fiRZ/vLMvA4b79r6mn3WJ8aMIaodG6CQzmDNcsF
 br+XVp8rc58m9q69BTzDH0xTStxXiwozyISAe2VGbGUbK9ngU/H1RX0Y01uQ9Dz0KfyjA0/Z
 QOBa4N1n1qoKFzoxTpu0Vyumkc5EnTk8NdWszt7UAtNSaIZcBuWHR7Kp0DqRHwom0kgTiNXJ
 8uNgvvFTkPd2Pdz1BqbpN1Fj856xPuKIiqs5qXI2yh3GhntFDbTOwOU3rr3x5NEv3wFVojdi
 HcLM+KVf29YkRHzuEQT5YT9h6qTk2aFRqq3HSXrP56hQ3whR7bQtziJspkuj+ekeTxcZ5lr4
 9FJI03hQJ4HbHn6x/Xw0+WjIOo4jBeUEI7kCDQRaQk2TARAA4JCPcQcISPAKKC1n9VQxgdH3
 oMqxhJ+gh/0Yb394ZYWLf7qOVQf/MgALPQIIFpcwYrw7gK4hsN7kj1vwPFy9JIqZtkgbmJHm
 aCj1LkZuf8tp5uvqzMZGcgm28IO6qDhPggeUE3hfA/y5++Vt0Jsmrz5zVPY0bOrLh1bItLnF
 U3uoaHWkAi/rhM6WwlsxemefzKulXoR9PIGVZ/QGjBGsTkNbTpiz2KsN+Ff/ZgjBJzGQNgha
 kc6a+eXyGC0YE8fRoTQekTi/GqGY7gfRKkgZDPi0Ul0sPZQJo07Dpw0nh5l6sOO+1yXygcoA
 V7I4bUeANZ9QJzbzZALgtxbT6jTKC0HUbF9iFb0yEkffkQuhhIqud7RkITe25hZePN8Y6Px0
 yF4lEVW/Ti91jMSb4mpZiAaIFcdDV0CAtIYHAcK1ZRVz//+72o4gMZlRxowxduMyRs3L5rE0
 ZkFQ6aPan+NBtEk1v3RPqnsQwJsonmiEgfbvybyBpP5MzRZnoAxfQ9vyyXoI5ofbl/+l9wv8
 mosKNWIjiQsX3KiyaqygtD/yed5diie5nA7eT6IjL92WfgSelhBCL4jV0fL4w8hah2Azu0Jg
 1ZtjjgoDObcAKQ5dLJA0IDsgH/X/G+ZMvkPpPIVaS5QWkiv66hixdKte/4iUrN+4waxJLCit
 1KGC2xPJ2UUAEQEAAYkCPAQYAQgAJhYhBIo5khw0X1N0AbpbwBFSLljzHXMuBQJaQk2TAhsM
 BQkJZgGAAAoJEBFSLljzHXMuOb0P/1EnY4Y6LfQ6bmhJQ6epA3fB70hRWCQsuPYLAgPKRoXy
 kmWH4ljqQDbA55TtIpnod/woR0IDnZcD7E9cyGzM2rHvSLXTkHhgIWacZHZopAUzq4j0lhiJ
 Wu57freQPU4rzMVGZXBktUsDMsJwp/3Tl2Kjqylh90qIOlB9laUusLIbl4w5J3EscIJzWvdL
 y1lJLtBmus/t75wN/aIB8l9YBKGuy0L4SAmjhN52pCgP/S+ANEKvdghQco51a4jD2Pv2uYH7
 nUU/Y70AmqOHjPR+qZ0hAUw6B+UtWQ+Fl587Qqi2XPUzdA8G2EjGFFPRlnhf2H/gOyAfeVYL
 NDwDgm9Yzp7Rx0O1QOnQsXTHqk7K38AdSdM2li/I/zegeblInnLi08Gq6mT6RkD6wV9HE5U3
 EIU0rDPyJo54MW39wGjfC2+PM5I0xebbxtnuTewRchVVfm7UWgLAy11pV3xM4wMSJOuqVMOz
 jYpWKYxDTpvsZ0ginUUY993Gb8k/CxjABEMUGVHhQPZ0OzjHIKS6cTzN6ue8bB+CGOLCaQp1
 C0NRT5Tn9zpLxtf5nBExFd/zVENY5vAV2ZbKQdemO54O7j6B9DSgVRrm83GCZxbL4d+qTYBF
 3tSCWw/6SG1F3q9gR9QrSC2YRjCmhijUVEh6FhZwB58TNZ1sEEttrps8TDa5tUd9
Message-ID: <0b49ec72-b8a6-8631-e21d-9efd30354e1d@gmail.com>
Date:   Sun, 3 Mar 2019 00:17:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <8F6AC5BF-F50B-4C30-A73B-98526AF181EB@holtmann.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,

On 3/2/19 5:46 PM, Marcel Holtmann wrote:
> Hi Tomas,
> 
>> hci_inquiry_result_with_rssi_evt() can perform out of bound reads
>> on skb->data as a bound check is missing.
>>
>> Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
>> Reported-by: syzbot+cec7a50c412a2c03f8f5@syzkaller.appspotmail.com
>> Reported-by: syzbot+660883c56e2fa65d4497@syzkaller.appspotmail.com
>> ---
>> Syzkaler reports:
>> https://syzkaller.appspot.com/bug?id=d708485af9edc3af35f3b4d554e827c6c8bf6b0f
>> https://syzkaller.appspot.com/bug?id=3acd1155d48a5acc5d76711568b04926945a6885
>>
>> net/bluetooth/hci_event.c | 4 ++++
>> 1 file changed, 4 insertions(+)
>>
>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
>> index ac2826ce162b..aa953d23bb72 100644
>> --- a/net/bluetooth/hci_event.c
>> +++ b/net/bluetooth/hci_event.c
>> @@ -3983,6 +3983,10 @@ static void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev,
>> 		for (; num_rsp; num_rsp--, info++) {
>> 			u32 flags;
>>
>> +			if ((void *)(info + sizeof(info)) >
>> +			   (void *)(skb->data + skb->len))
>> +				break;
>> +
> 
> first of all, the loop exists twice here. If one is vulnerable, then the second is a well. And second, can we not just do this inside the for-condition check or a lot simpler than this void casting fun.
> 

1. The other for loop is not vulnerable because of the `if` that wraps
the loops. Unfortunately the condition only provides bound checking for
the "else" branch.

2. Sure. I was just getting some compiler warning like "calculated value
but unused" when putting the additional condition. By the way I am
curious to see how to avoid this void casting.

Regards,
Tomas



