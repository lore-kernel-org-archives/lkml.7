Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC5CCA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 12:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BFF22087E
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 12:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="VH2JjfTE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfJ3MtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 08:49:05 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44229 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbfJ3MtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 08:49:04 -0400
Received: by mail-lf1-f66.google.com with SMTP id v4so1434110lfd.11
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 05:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sSxMD93SgrMKa1m5daPa8vTyvv+ZCSpaIY9FPy5hVnc=;
        b=VH2JjfTED6tJP9SgurJTiQJxYZXJDKAJ+tS5boUHlN5RVihbMQ5GRxPToaX+sOmjTV
         7mupqAEL3KPSSblg3l1/0p6MMy9rGB1/wwKo9JNymSfGafIJm4bEu4J+zzspaHhypkFM
         QmMllYvN4VWySnPjqfn84YqVMHDSPYrMCmkyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sSxMD93SgrMKa1m5daPa8vTyvv+ZCSpaIY9FPy5hVnc=;
        b=AUy7EC9salhXNf/L2TUVPQTmZ6xQtUDUfp6NSpf7VUc6DR5w6sK/O0USb8FK4llXvK
         /oeO+h5WziB066K11aWtwwl9P1MgmAVXtbbxf2qBlFCi2AsUhorC+CJeh4rXWXIUVSnR
         9jVB9uB/YOnN+8EbogtZhe07JRsgbjMfXggQcjjdyTruEEHhJQr36X2CSytsLuqEWyH8
         lwM8aitzfv7ZuSxXWtlUbkjZktaQJcE3UYngqeh0QTVAjxkhHJPAlBECs3dS7xfLJJoz
         hYHkqf9Lics2CM7XCk0uW/bZhFN6VKOMqAJjsZ2DbFTWsOMiCa63AKbYs2XFh/P09prO
         BMdg==
X-Gm-Message-State: APjAAAU0pSXD6a4zTN+jSGlinHtPcFFHB9dkh6xJNoeXotj0ZUKV3CoB
        urNoEhUqxT2+DABD3+09tftaw6eDaE8=
X-Google-Smtp-Source: APXvYqysJnmPCrxbSN5rEZs/my9yJdqOhMLqkjhxEuIQURnaFWauUaVQWJ3C/z/48K4+r7AZjwDRdA==
X-Received: by 2002:a19:3845:: with SMTP id d5mr5838987lfj.162.1572439741746;
        Wed, 30 Oct 2019 05:49:01 -0700 (PDT)
Received: from [192.168.0.107] (84-238-136-197.ip.btc-net.bg. [84.238.136.197])
        by smtp.gmail.com with ESMTPSA id b4sm911745ljp.84.2019.10.30.05.49.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2019 05:49:01 -0700 (PDT)
Subject: Re: [PATCH net-next v2 4/4] bonding: balance ICMP echoes in layer3+4
 mode
To:     Eric Dumazet <eric.dumazet@gmail.com>,
        Matteo Croce <mcroce@redhat.com>, netdev@vger.kernel.org
Cc:     Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S . Miller" <davem@davemloft.net>,
        Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Paul Blakey <paulb@mellanox.com>, linux-kernel@vger.kernel.org
References: <20191029135053.10055-1-mcroce@redhat.com>
 <20191029135053.10055-5-mcroce@redhat.com>
 <5be14e4e-807f-486d-d11a-3113901e72fe@cumulusnetworks.com>
 <576a4a96-861b-6a86-b059-6621a22d191c@gmail.com>
 <afdfd237-124d-0050-606f-cb5516c9e4d8@cumulusnetworks.com>
 <294b9604-8d43-4a31-9324-6368c584fd63@gmail.com>
From:   Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <4d4f88c6-8b95-5d9b-7e14-3cdc2f660d3f@cumulusnetworks.com>
Date:   Wed, 30 Oct 2019 14:48:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <294b9604-8d43-4a31-9324-6368c584fd63@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/10/2019 01:04, Eric Dumazet wrote:
> 
> 
> On 10/29/19 2:50 PM, Nikolay Aleksandrov wrote:
> 
>> Right, I was just giving it as an example. Your suggestion sounds much better and
>> wouldn't interfere with other layers, plus we already use skb->hash in bond_xmit_hash()
>> and skb_set_owner_w() sets l4_hash if txhash is present which is perfect.
>>
>> One thing - how do we deal with sk_rethink_txhash() ? I guess we'll need some way to
>> signal that the user specified the txhash and it is not to be recomputed ?
>> That can also be used to avoid the connect txhash set as well if SO_TXHASH was set prior
>> to the connect. It's quite late here, I'll look into it more tomorrow. :)
> 
> I guess that we have something similar with SO_RCVBUF/SO_SNDBUF
> 
> autotuning is disabled when/if they are used :
> 
>  SOCK_RCVBUF_LOCK & SOCK_SNDBUF_LOCK
> 
> We could add a SOCK_TXHASH_LOCK so that sk_rethink_txhash() does nothing if
> user forced a TXHASH value.
> 
> Something like the following (probably not complete) patch.
> 

Actually I think it's ok. I had a similar change last night sans the userlocks.
I just built and tested a kernel with it successfully using the bonding.
The only case that doesn't seem to work is a raw socket without hdrincl, IIUC due to
the direct alloc_skb() (transhdrlen == 0) in ip_append_data().
Unless you have other concerns could you please submit it formally ?

> diff --git a/include/net/sock.h b/include/net/sock.h
> index 380312cc67a9d9ee8720eb2db82b1f7f8a5615ab..a8882738710eaa9d9d629e1207837a798401a594 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -1354,6 +1354,7 @@ static inline int __sk_prot_rehash(struct sock *sk)
>  #define SOCK_RCVBUF_LOCK       2
>  #define SOCK_BINDADDR_LOCK     4
>  #define SOCK_BINDPORT_LOCK     8
> +#define SOCK_TXHASH_LOCK       16
>  
>  struct socket_alloc {
>         struct socket socket;
> @@ -1852,7 +1853,8 @@ static inline u32 net_tx_rndhash(void)
>  
>  static inline void sk_set_txhash(struct sock *sk)
>  {
> -       sk->sk_txhash = net_tx_rndhash();
> +       if (!(sk->sk_userlocks & SOCK_TXHASH_LOCK))
> +               sk->sk_txhash = net_tx_rndhash();
>  }
>  
>  static inline void sk_rethink_txhash(struct sock *sk)
> diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
> index 77f7c1638eb1ce7d3e143bbffd60056e472b1122..998be6ee7991de3a76d4ad33df3a38dbe791eae8 100644
> --- a/include/uapi/asm-generic/socket.h
> +++ b/include/uapi/asm-generic/socket.h
> @@ -118,6 +118,7 @@
>  #define SO_SNDTIMEO_NEW         67
>  
>  #define SO_DETACH_REUSEPORT_BPF 68
> +#define SO_TXHASH              69
>  
>  #if !defined(__KERNEL__)
>  
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 997b352c2a72ee39f00b102a553ac1191202b74f..85b85dffd462bc3b497e0432100ff24b759832e0 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -770,6 +770,10 @@ int sock_setsockopt(struct socket *sock, int level, int optname,
>         case SO_BROADCAST:
>                 sock_valbool_flag(sk, SOCK_BROADCAST, valbool);
>                 break;
> +       case SO_TXHASH:
> +               sk->sk_txhash = val;
> +               sk->sk_userlocks |= SOCK_TXHASH_LOCK;
> +               break;
>         case SO_SNDBUF:
>                 /* Don't error on this BSD doesn't and if you think
>                  * about it this is right. Otherwise apps have to
> @@ -1249,6 +1253,10 @@ int sock_getsockopt(struct socket *sock, int level, int optname,
>                 v.val = sock_flag(sk, SOCK_BROADCAST);
>                 break;
>  
> +       case SO_TXHASH:
> +               v.val = sk->sk_txhash;
> +               break;
> +
>         case SO_SNDBUF:
>                 v.val = sk->sk_sndbuf;
>                 break;
> 

