Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DX_TEXT_01,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B518C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 20:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A62C217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 20:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJZKzqyl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387748AbfHZUMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 16:12:39 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35273 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729777AbfHZUMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 16:12:38 -0400
Received: by mail-lj1-f194.google.com with SMTP id l14so16307067lje.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 13:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EkSa8I3EjzWT4qDMRwq9SJtHrnK2UMPfSG4QRztacug=;
        b=TJZKzqyliKXPiDrlGt6pW0gVr/gk+mwIU+cAefPOSmJpKEGeJmVJF7DPOGmN0/gNVU
         +1emXGTJMcjp7+PKi41aig8zZT4EHjCwjCmklP5oOn/OZQxg5ITvwDzP5qZ6KAVMVE6L
         ff+7wsC/F3tVSiTsa/ZHONuWh23Wxf3Q/A/QLEBaWUuEhfLGSAmJHkI/Rd66VGU6HgeS
         h89Ubgrwxpon0wlUTxkFmDYsosVuFufFUHgT3xIu2gnSRY5BUOZ/hT4wzayxN9iYbvCr
         midUIUz2xo2eKikbyLrduyJSJBXEP/GnRvxjPbPlQQ+H9F+XE0oL7hVNo7ZlBtwsglud
         DTnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EkSa8I3EjzWT4qDMRwq9SJtHrnK2UMPfSG4QRztacug=;
        b=GOTrYUxOAt3g9bWX0M0NG48k9O/Q9btOelPFAn5O4tXtoGYvBEn1zG6l7c1rPtyXoU
         1MkMAlY9y7KgOrZrrU+8LAhoEeNfqdQOAMEFl1EuTrtzAtcMZ89SaJu2uFJj430KPgnl
         marjq6cduOdbQpjsO9Q/g0HMjAFHcrdmQ+hbs4phClnnAWwzoovTrjlmRXllY7h9a8G3
         WVLQj+pTBRAKfL9hRAKLVhq5bPYgSp78bsxwDNbIO/zVlIrGBso9ci36l5YwU3NUdTjx
         oFYGjtnrqrS7j4dEAVinZzmYLqLBVPYito8mO565Mit+Q95kY3KR/t6+ta4F4nulT2Zd
         EjvA==
X-Gm-Message-State: APjAAAWkJtixuTxce5KnH2mZwXFP94mELpGXsd06R5GyEurWx15lLqnv
        6NK99wRo1zXvDiLXG2fa6IxGLOU0qakYb5IH1meMiQ==
X-Google-Smtp-Source: APXvYqzj9wsXSY1DvSbUdbI1kDQ8Za++niAr1XEVNHfTDwpHEH3zTU3cmcuEufj8z+Fx3jjhLmwvz2ZGSfnkW+hg0EI=
X-Received: by 2002:a2e:429c:: with SMTP id h28mr11379631ljf.7.1566850355705;
 Mon, 26 Aug 2019 13:12:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190823081316.28478-1-thomas_os@shipmail.org> <20190823081316.28478-4-thomas_os@shipmail.org>
In-Reply-To: <20190823081316.28478-4-thomas_os@shipmail.org>
From:   Dave Airlie <airlied@gmail.com>
Date:   Tue, 27 Aug 2019 06:12:23 +1000
Message-ID: <CAPM=9txEHSv8M4Q7A38JQpUoQJjess5vvwkXbJmk=0XgNhEJ9g@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] drm/vmwgfx: Update the backdoor call with support
 for new instructions
To:     =?UTF-8?Q?Thomas_Hellstr=C3=B6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        pv-drivers@vmware.com, "the arch/x86 maintainers" <x86@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Doug Covelli <dcovelli@vmware.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux-graphics-maintainer <linux-graphics-maintainer@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Dave Airlie <airlied@redhat.com>

(for merging via x86 trees).

Dave.

On Fri, 23 Aug 2019 at 18:13, Thomas Hellstr=C3=B6m (VMware)
<thomas_os@shipmail.org> wrote:
>
> From: Thomas Hellstrom <thellstrom@vmware.com>
>
> Use the definition provided by include/asm/vmware.h
>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: <x86@kernel.org>
> Cc: <dri-devel@lists.freedesktop.org>
> Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
> Reviewed-by: Doug Covelli <dcovelli@vmware.com>
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_msg.c | 21 +++++++++--------
>  drivers/gpu/drm/vmwgfx/vmwgfx_msg.h | 35 +++++++++++++++--------------
>  2 files changed, 28 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c b/drivers/gpu/drm/vmwgfx=
/vmwgfx_msg.c
> index 81a86c3b77bc..1281e52898ee 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
> @@ -45,8 +45,6 @@
>  #define RETRIES                 3
>
>  #define VMW_HYPERVISOR_MAGIC    0x564D5868
> -#define VMW_HYPERVISOR_PORT     0x5658
> -#define VMW_HYPERVISOR_HB_PORT  0x5659
>
>  #define VMW_PORT_CMD_MSG        30
>  #define VMW_PORT_CMD_HB_MSG     0
> @@ -92,7 +90,7 @@ static int vmw_open_channel(struct rpc_channel *channel=
, unsigned int protocol)
>
>         VMW_PORT(VMW_PORT_CMD_OPEN_CHANNEL,
>                 (protocol | GUESTMSG_FLAG_COOKIE), si, di,
> -               VMW_HYPERVISOR_PORT,
> +               0,
>                 VMW_HYPERVISOR_MAGIC,
>                 eax, ebx, ecx, edx, si, di);
>
> @@ -125,7 +123,7 @@ static int vmw_close_channel(struct rpc_channel *chan=
nel)
>
>         VMW_PORT(VMW_PORT_CMD_CLOSE_CHANNEL,
>                 0, si, di,
> -               (VMW_HYPERVISOR_PORT | (channel->channel_id << 16)),
> +               channel->channel_id << 16,
>                 VMW_HYPERVISOR_MAGIC,
>                 eax, ebx, ecx, edx, si, di);
>
> @@ -159,7 +157,8 @@ static unsigned long vmw_port_hb_out(struct rpc_chann=
el *channel,
>                 VMW_PORT_HB_OUT(
>                         (MESSAGE_STATUS_SUCCESS << 16) | VMW_PORT_CMD_HB_=
MSG,
>                         msg_len, si, di,
> -                       VMW_HYPERVISOR_HB_PORT | (channel->channel_id << =
16),
> +                       VMWARE_HYPERVISOR_HB | (channel->channel_id << 16=
) |
> +                       VMWARE_HYPERVISOR_OUT,
>                         VMW_HYPERVISOR_MAGIC, bp,
>                         eax, ebx, ecx, edx, si, di);
>
> @@ -180,7 +179,7 @@ static unsigned long vmw_port_hb_out(struct rpc_chann=
el *channel,
>
>                 VMW_PORT(VMW_PORT_CMD_MSG | (MSG_TYPE_SENDPAYLOAD << 16),
>                          word, si, di,
> -                        VMW_HYPERVISOR_PORT | (channel->channel_id << 16=
),
> +                        channel->channel_id << 16,
>                          VMW_HYPERVISOR_MAGIC,
>                          eax, ebx, ecx, edx, si, di);
>         }
> @@ -212,7 +211,7 @@ static unsigned long vmw_port_hb_in(struct rpc_channe=
l *channel, char *reply,
>                 VMW_PORT_HB_IN(
>                         (MESSAGE_STATUS_SUCCESS << 16) | VMW_PORT_CMD_HB_=
MSG,
>                         reply_len, si, di,
> -                       VMW_HYPERVISOR_HB_PORT | (channel->channel_id << =
16),
> +                       VMWARE_HYPERVISOR_HB | (channel->channel_id << 16=
),
>                         VMW_HYPERVISOR_MAGIC, bp,
>                         eax, ebx, ecx, edx, si, di);
>
> @@ -229,7 +228,7 @@ static unsigned long vmw_port_hb_in(struct rpc_channe=
l *channel, char *reply,
>
>                 VMW_PORT(VMW_PORT_CMD_MSG | (MSG_TYPE_RECVPAYLOAD << 16),
>                          MESSAGE_STATUS_SUCCESS, si, di,
> -                        VMW_HYPERVISOR_PORT | (channel->channel_id << 16=
),
> +                        channel->channel_id << 16,
>                          VMW_HYPERVISOR_MAGIC,
>                          eax, ebx, ecx, edx, si, di);
>
> @@ -268,7 +267,7 @@ static int vmw_send_msg(struct rpc_channel *channel, =
const char *msg)
>
>                 VMW_PORT(VMW_PORT_CMD_SENDSIZE,
>                         msg_len, si, di,
> -                       VMW_HYPERVISOR_PORT | (channel->channel_id << 16)=
,
> +                       channel->channel_id << 16,
>                         VMW_HYPERVISOR_MAGIC,
>                         eax, ebx, ecx, edx, si, di);
>
> @@ -326,7 +325,7 @@ static int vmw_recv_msg(struct rpc_channel *channel, =
void **msg,
>
>                 VMW_PORT(VMW_PORT_CMD_RECVSIZE,
>                         0, si, di,
> -                       (VMW_HYPERVISOR_PORT | (channel->channel_id << 16=
)),
> +                       channel->channel_id << 16,
>                         VMW_HYPERVISOR_MAGIC,
>                         eax, ebx, ecx, edx, si, di);
>
> @@ -370,7 +369,7 @@ static int vmw_recv_msg(struct rpc_channel *channel, =
void **msg,
>
>                 VMW_PORT(VMW_PORT_CMD_RECVSTATUS,
>                         MESSAGE_STATUS_SUCCESS, si, di,
> -                       (VMW_HYPERVISOR_PORT | (channel->channel_id << 16=
)),
> +                       channel->channel_id << 16,
>                         VMW_HYPERVISOR_MAGIC,
>                         eax, ebx, ecx, edx, si, di);
>
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.h b/drivers/gpu/drm/vmwgfx=
/vmwgfx_msg.h
> index 4907e50fb20a..f685c7071dec 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.h
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.h
> @@ -32,6 +32,7 @@
>  #ifndef _VMWGFX_MSG_H
>  #define _VMWGFX_MSG_H
>
> +#include <asm/vmware.h>
>
>  /**
>   * Hypervisor-specific bi-directional communication channel.  Should nev=
er
> @@ -44,7 +45,7 @@
>   * @in_ebx: [IN] Message Len, through EBX
>   * @in_si: [IN] Input argument through SI, set to 0 if not used
>   * @in_di: [IN] Input argument through DI, set ot 0 if not used
> - * @port_num: [IN] port number + [channel id]
> + * @flags: [IN] hypercall flags + [channel id]
>   * @magic: [IN] hypervisor magic value
>   * @eax: [OUT] value of EAX register
>   * @ebx: [OUT] e.g. status from an HB message status command
> @@ -54,10 +55,10 @@
>   * @di:  [OUT]
>   */
>  #define VMW_PORT(cmd, in_ebx, in_si, in_di,    \
> -                port_num, magic,               \
> +                flags, magic,          \
>                  eax, ebx, ecx, edx, si, di)    \
>  ({                                             \
> -       asm volatile ("inl %%dx, %%eax;" :      \
> +       asm volatile (VMWARE_HYPERCALL :        \
>                 "=3Da"(eax),                      \
>                 "=3Db"(ebx),                      \
>                 "=3Dc"(ecx),                      \
> @@ -67,7 +68,7 @@
>                 "a"(magic),                     \
>                 "b"(in_ebx),                    \
>                 "c"(cmd),                       \
> -               "d"(port_num),                  \
> +               "d"(flags),                     \
>                 "S"(in_si),                     \
>                 "D"(in_di) :                    \
>                 "memory");                      \
> @@ -85,7 +86,7 @@
>   * @in_ecx: [IN] Message Len, through ECX
>   * @in_si: [IN] Input argument through SI, set to 0 if not used
>   * @in_di: [IN] Input argument through DI, set to 0 if not used
> - * @port_num: [IN] port number + [channel id]
> + * @flags: [IN] hypercall flags + [channel id]
>   * @magic: [IN] hypervisor magic value
>   * @bp:  [IN]
>   * @eax: [OUT] value of EAX register
> @@ -98,12 +99,12 @@
>  #ifdef __x86_64__
>
>  #define VMW_PORT_HB_OUT(cmd, in_ecx, in_si, in_di,     \
> -                       port_num, magic, bp,            \
> +                       flags, magic, bp,               \
>                         eax, ebx, ecx, edx, si, di)     \
>  ({                                                     \
>         asm volatile ("push %%rbp;"                     \
>                 "mov %12, %%rbp;"                       \
> -               "rep outsb;"                            \
> +               VMWARE_HYPERCALL_HB_OUT                 \
>                 "pop %%rbp;" :                          \
>                 "=3Da"(eax),                              \
>                 "=3Db"(ebx),                              \
> @@ -114,7 +115,7 @@
>                 "a"(magic),                             \
>                 "b"(cmd),                               \
>                 "c"(in_ecx),                            \
> -               "d"(port_num),                          \
> +               "d"(flags),                             \
>                 "S"(in_si),                             \
>                 "D"(in_di),                             \
>                 "r"(bp) :                               \
> @@ -123,12 +124,12 @@
>
>
>  #define VMW_PORT_HB_IN(cmd, in_ecx, in_si, in_di,      \
> -                      port_num, magic, bp,             \
> +                      flags, magic, bp,                \
>                        eax, ebx, ecx, edx, si, di)      \
>  ({                                                     \
>         asm volatile ("push %%rbp;"                     \
>                 "mov %12, %%rbp;"                       \
> -               "rep insb;"                             \
> +               VMWARE_HYPERCALL_HB_IN                  \
>                 "pop %%rbp" :                           \
>                 "=3Da"(eax),                              \
>                 "=3Db"(ebx),                              \
> @@ -139,7 +140,7 @@
>                 "a"(magic),                             \
>                 "b"(cmd),                               \
>                 "c"(in_ecx),                            \
> -               "d"(port_num),                          \
> +               "d"(flags),                             \
>                 "S"(in_si),                             \
>                 "D"(in_di),                             \
>                 "r"(bp) :                               \
> @@ -157,13 +158,13 @@
>   * just pushed it.
>   */
>  #define VMW_PORT_HB_OUT(cmd, in_ecx, in_si, in_di,     \
> -                       port_num, magic, bp,            \
> +                       flags, magic, bp,               \
>                         eax, ebx, ecx, edx, si, di)     \
>  ({                                                     \
>         asm volatile ("push %12;"                       \
>                 "push %%ebp;"                           \
>                 "mov 0x04(%%esp), %%ebp;"               \
> -               "rep outsb;"                            \
> +               VMWARE_HYPERCALL_HB_OUT                 \
>                 "pop %%ebp;"                            \
>                 "add $0x04, %%esp;" :                   \
>                 "=3Da"(eax),                              \
> @@ -175,7 +176,7 @@
>                 "a"(magic),                             \
>                 "b"(cmd),                               \
>                 "c"(in_ecx),                            \
> -               "d"(port_num),                          \
> +               "d"(flags),                             \
>                 "S"(in_si),                             \
>                 "D"(in_di),                             \
>                 "m"(bp) :                               \
> @@ -184,13 +185,13 @@
>
>
>  #define VMW_PORT_HB_IN(cmd, in_ecx, in_si, in_di,      \
> -                      port_num, magic, bp,             \
> +                      flags, magic, bp,                \
>                        eax, ebx, ecx, edx, si, di)      \
>  ({                                                     \
>         asm volatile ("push %12;"                       \
>                 "push %%ebp;"                           \
>                 "mov 0x04(%%esp), %%ebp;"               \
> -               "rep insb;"                             \
> +               VMWARE_HYPERCALL_HB_IN                  \
>                 "pop %%ebp;"                            \
>                 "add $0x04, %%esp;" :                   \
>                 "=3Da"(eax),                              \
> @@ -202,7 +203,7 @@
>                 "a"(magic),                             \
>                 "b"(cmd),                               \
>                 "c"(in_ecx),                            \
> -               "d"(port_num),                          \
> +               "d"(flags),                             \
>                 "S"(in_si),                             \
>                 "D"(in_di),                             \
>                 "m"(bp) :                               \
> --
> 2.20.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
