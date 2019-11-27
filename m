Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF83C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 10:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5057C20722
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 10:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UDumV1g9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfK0KYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 05:24:06 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40766 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbfK0KYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 05:24:05 -0500
Received: by mail-qt1-f196.google.com with SMTP id z22so3952741qto.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 02:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CgY/baMdTAL9hJOdaFgTnb73I3ekEZVzC9OqzKab+n0=;
        b=UDumV1g9t39JIU/6VlzSxUykfev6IrNpEYuFSXriVvkHg7DnFBKp921Bn9Xxy3rFZ4
         9IV12hf8t6bX40M6CvgcCm8grdssyg7zqS/zjTQboo7TEmiNr1c0iZuwWFDJmshAZn95
         e6PjC/Su3/wNh0Arj2o/Ne7w3pXz0uerfeZNoJ0yfIshVN1KvpRndr6a0hnwbMsWzIBK
         ydy6WSRJICOedoI1hEhxxkx3VF9RDAMvY5nmNQguIPplI6Kk7tU7feo0BcMmiBb42OPh
         FukuQM6TZIEVOcz/yLBlSNYcVhOEny7FY7ygEiOV998PU350Tm4LvdUfPNath04WGTYN
         oN0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CgY/baMdTAL9hJOdaFgTnb73I3ekEZVzC9OqzKab+n0=;
        b=R3hfT30CLHsA3KEGRhCeLaIqoqDQJkpbtSrJ8SHlRlsElkcJwziB4e93Q7k1MwXPIx
         wrK0EM7gRJkXHJy3gqa8i6Kza8cnOERuoUPZgay8iEMBVBZ+5dfawyV9mQ/7+j2ioZMI
         e0yQzLrTVuOWmGBHj733sittKVd6GKoREfjppBqc00LW0JO8bUbDLYcQtsssre00n9o0
         r0TdP1qlo2O/q3P8kRl5p+LI3l5nyUSXV75uLxoo0jMYbmJMsjt8ogIjn/Fq9a0AQTSA
         z39Gs7FpfMkcH20DrJdJmwF83qto5p82lPia7GB+57ISSwjBmzVqBmPMamQ9z1MdyE+b
         u8WQ==
X-Gm-Message-State: APjAAAVbvNQejMzyl0HQJGl3aKDI13XXB7govEVUct4VZCk3kiaZYoGh
        7H1Sv+wlS8wLoaPPAsj1bEeVpB0csqnDA42D/4aKu6eu
X-Google-Smtp-Source: APXvYqxDsj7bGC2nbVUGE5XumNcVjg5MIBn4NDk60cA4gtNwVKm5tHNirw/1z6jTMmKa30SEbWaKPYg2JMJ8+PC8B+8=
X-Received: by 2002:ac8:690c:: with SMTP id e12mr27696205qtr.239.1574850244325;
 Wed, 27 Nov 2019 02:24:04 -0800 (PST)
MIME-Version: 1.0
References: <20191112123938.2346-1-benjamin.gaignard@st.com>
In-Reply-To: <20191112123938.2346-1-benjamin.gaignard@st.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Wed, 27 Nov 2019 11:23:53 +0100
Message-ID: <CA+M3ks5cR8rxw84vce+ib5YoHmM-EZfQ3rS_PgidRgYQ9zgLpQ@mail.gmail.com>
Subject: Re: [PATCH] drm/dp_mst: Fix W=1 warnings
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mer. 13 nov. 2019 =C3=A0 08:55, Benjamin Gaignard
<benjamin.gaignard@st.com> a =C3=A9crit :
>
> Fix the warnings that show up with W=3D1.
> They are all about unused but set variables.

gentle ping to reviewers,

Thanks,
Benjamin
>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c | 50 +++++++++++++----------------=
------
>  1 file changed, 19 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_=
dp_mst_topology.c
> index b854a422a523..6ff554be8000 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -672,7 +672,6 @@ static bool drm_dp_sideband_msg_build(struct drm_dp_s=
ideband_msg_rx *msg,
>                                       u8 *replybuf, u8 replybuflen, bool =
hdr)
>  {
>         int ret;
> -       u8 crc4;
>
>         if (hdr) {
>                 u8 hdrlen;
> @@ -714,8 +713,6 @@ static bool drm_dp_sideband_msg_build(struct drm_dp_s=
ideband_msg_rx *msg,
>         }
>
>         if (msg->curchunk_idx >=3D msg->curchunk_len) {
> -               /* do CRC */
> -               crc4 =3D drm_dp_msg_data_crc4(msg->chunk, msg->curchunk_l=
en - 1);
>                 /* copy chunk into bigger msg */
>                 memcpy(&msg->msg[msg->curlen], msg->chunk, msg->curchunk_=
len - 1);
>                 msg->curlen +=3D msg->curchunk_len - 1;
> @@ -1744,14 +1741,13 @@ static u8 drm_dp_calculate_rad(struct drm_dp_mst_=
port *port,
>   */
>  static bool drm_dp_port_setup_pdt(struct drm_dp_mst_port *port)
>  {
> -       int ret;
>         u8 rad[6], lct;
>         bool send_link =3D false;
>         switch (port->pdt) {
>         case DP_PEER_DEVICE_DP_LEGACY_CONV:
>         case DP_PEER_DEVICE_SST_SINK:
>                 /* add i2c over sideband */
> -               ret =3D drm_dp_mst_register_i2c_bus(&port->aux);
> +               drm_dp_mst_register_i2c_bus(&port->aux);
>                 break;
>         case DP_PEER_DEVICE_MST_BRANCHING:
>                 lct =3D drm_dp_calculate_rad(port, rad);
> @@ -1821,21 +1817,18 @@ ssize_t drm_dp_mst_dpcd_write(struct drm_dp_aux *=
aux,
>
>  static void drm_dp_check_mstb_guid(struct drm_dp_mst_branch *mstb, u8 *g=
uid)
>  {
> -       int ret;
> -
>         memcpy(mstb->guid, guid, 16);
>
>         if (!drm_dp_validate_guid(mstb->mgr, mstb->guid)) {
>                 if (mstb->port_parent) {
> -                       ret =3D drm_dp_send_dpcd_write(
> +                       drm_dp_send_dpcd_write(
>                                         mstb->mgr,
>                                         mstb->port_parent,
>                                         DP_GUID,
>                                         16,
>                                         mstb->guid);
>                 } else {
> -
> -                       ret =3D drm_dp_dpcd_write(
> +                       drm_dp_dpcd_write(
>                                         mstb->mgr->aux,
>                                         DP_GUID,
>                                         mstb->guid,
> @@ -2427,14 +2420,14 @@ static void drm_dp_send_link_address(struct drm_d=
p_mst_topology_mgr *mgr,
>  {
>         struct drm_dp_sideband_msg_tx *txmsg;
>         struct drm_dp_link_address_ack_reply *reply;
> -       int i, len, ret;
> +       int i, ret;
>
>         txmsg =3D kzalloc(sizeof(*txmsg), GFP_KERNEL);
>         if (!txmsg)
>                 return;
>
>         txmsg->dst =3D mstb;
> -       len =3D build_link_address(txmsg);
> +       build_link_address(txmsg);
>
>         mstb->link_address_sent =3D true;
>         drm_dp_queue_down_tx(mgr, txmsg);
> @@ -2476,7 +2469,6 @@ drm_dp_send_enum_path_resources(struct drm_dp_mst_t=
opology_mgr *mgr,
>  {
>         struct drm_dp_enum_path_resources_ack_reply *path_res;
>         struct drm_dp_sideband_msg_tx *txmsg;
> -       int len;
>         int ret;
>
>         txmsg =3D kzalloc(sizeof(*txmsg), GFP_KERNEL);
> @@ -2484,7 +2476,7 @@ drm_dp_send_enum_path_resources(struct drm_dp_mst_t=
opology_mgr *mgr,
>                 return -ENOMEM;
>
>         txmsg->dst =3D mstb;
> -       len =3D build_enum_path_resources(txmsg, port->port_num);
> +       build_enum_path_resources(txmsg, port->port_num);
>
>         drm_dp_queue_down_tx(mgr, txmsg);
>
> @@ -2567,7 +2559,7 @@ static int drm_dp_payload_send_msg(struct drm_dp_ms=
t_topology_mgr *mgr,
>  {
>         struct drm_dp_sideband_msg_tx *txmsg;
>         struct drm_dp_mst_branch *mstb;
> -       int len, ret, port_num;
> +       int ret, port_num;
>         u8 sinks[DRM_DP_MAX_SDP_STREAMS];
>         int i;
>
> @@ -2592,9 +2584,9 @@ static int drm_dp_payload_send_msg(struct drm_dp_ms=
t_topology_mgr *mgr,
>                 sinks[i] =3D i;
>
>         txmsg->dst =3D mstb;
> -       len =3D build_allocate_payload(txmsg, port_num,
> -                                    id,
> -                                    pbn, port->num_sdp_streams, sinks);
> +       build_allocate_payload(txmsg, port_num,
> +                              id,
> +                              pbn, port->num_sdp_streams, sinks);
>
>         drm_dp_queue_down_tx(mgr, txmsg);
>
> @@ -2623,7 +2615,7 @@ int drm_dp_send_power_updown_phy(struct drm_dp_mst_=
topology_mgr *mgr,
>                                  struct drm_dp_mst_port *port, bool power=
_up)
>  {
>         struct drm_dp_sideband_msg_tx *txmsg;
> -       int len, ret;
> +       int ret;
>
>         port =3D drm_dp_mst_topology_get_port_validated(mgr, port);
>         if (!port)
> @@ -2636,7 +2628,7 @@ int drm_dp_send_power_updown_phy(struct drm_dp_mst_=
topology_mgr *mgr,
>         }
>
>         txmsg->dst =3D port->parent;
> -       len =3D build_power_updown_phy(txmsg, port->port_num, power_up);
> +       build_power_updown_phy(txmsg, port->port_num, power_up);
>         drm_dp_queue_down_tx(mgr, txmsg);
>
>         ret =3D drm_dp_mst_wait_tx_reply(port->parent, txmsg);
> @@ -2856,7 +2848,6 @@ static int drm_dp_send_dpcd_read(struct drm_dp_mst_=
topology_mgr *mgr,
>                                  struct drm_dp_mst_port *port,
>                                  int offset, int size, u8 *bytes)
>  {
> -       int len;
>         int ret =3D 0;
>         struct drm_dp_sideband_msg_tx *txmsg;
>         struct drm_dp_mst_branch *mstb;
> @@ -2871,7 +2862,7 @@ static int drm_dp_send_dpcd_read(struct drm_dp_mst_=
topology_mgr *mgr,
>                 goto fail_put;
>         }
>
> -       len =3D build_dpcd_read(txmsg, port->port_num, offset, size);
> +       build_dpcd_read(txmsg, port->port_num, offset, size);
>         txmsg->dst =3D port->parent;
>
>         drm_dp_queue_down_tx(mgr, txmsg);
> @@ -2909,7 +2900,6 @@ static int drm_dp_send_dpcd_write(struct drm_dp_mst=
_topology_mgr *mgr,
>                                   struct drm_dp_mst_port *port,
>                                   int offset, int size, u8 *bytes)
>  {
> -       int len;
>         int ret;
>         struct drm_dp_sideband_msg_tx *txmsg;
>         struct drm_dp_mst_branch *mstb;
> @@ -2924,7 +2914,7 @@ static int drm_dp_send_dpcd_write(struct drm_dp_mst=
_topology_mgr *mgr,
>                 goto fail_put;
>         }
>
> -       len =3D build_dpcd_write(txmsg, port->port_num, offset, size, byt=
es);
> +       build_dpcd_write(txmsg, port->port_num, offset, size, bytes);
>         txmsg->dst =3D mstb;
>
>         drm_dp_queue_down_tx(mgr, txmsg);
> @@ -3147,7 +3137,7 @@ static bool drm_dp_get_one_sb_msg(struct drm_dp_mst=
_topology_mgr *mgr, bool up)
>  {
>         int len;
>         u8 replyblock[32];
> -       int replylen, origlen, curreply;
> +       int replylen, curreply;
>         int ret;
>         struct drm_dp_sideband_msg_rx *msg;
>         int basereg =3D up ? DP_SIDEBAND_MSG_UP_REQ_BASE : DP_SIDEBAND_MS=
G_DOWN_REP_BASE;
> @@ -3167,7 +3157,6 @@ static bool drm_dp_get_one_sb_msg(struct drm_dp_mst=
_topology_mgr *mgr, bool up)
>         }
>         replylen =3D msg->curchunk_len + msg->curchunk_hdrlen;
>
> -       origlen =3D replylen;
>         replylen -=3D len;
>         curreply =3D len;
>         while (replylen > 0) {
> @@ -3959,17 +3948,16 @@ void drm_dp_mst_dump_topology(struct seq_file *m,
>         mutex_lock(&mgr->lock);
>         if (mgr->mst_primary) {
>                 u8 buf[DP_PAYLOAD_TABLE_SIZE];
> -               int ret;
>
> -               ret =3D drm_dp_dpcd_read(mgr->aux, DP_DPCD_REV, buf, DP_R=
ECEIVER_CAP_SIZE);
> +               drm_dp_dpcd_read(mgr->aux, DP_DPCD_REV, buf, DP_RECEIVER_=
CAP_SIZE);
>                 seq_printf(m, "dpcd: %*ph\n", DP_RECEIVER_CAP_SIZE, buf);
> -               ret =3D drm_dp_dpcd_read(mgr->aux, DP_FAUX_CAP, buf, 2);
> +               drm_dp_dpcd_read(mgr->aux, DP_FAUX_CAP, buf, 2);
>                 seq_printf(m, "faux/mst: %*ph\n", 2, buf);
> -               ret =3D drm_dp_dpcd_read(mgr->aux, DP_MSTM_CTRL, buf, 1);
> +               drm_dp_dpcd_read(mgr->aux, DP_MSTM_CTRL, buf, 1);
>                 seq_printf(m, "mst ctrl: %*ph\n", 1, buf);
>
>                 /* dump the standard OUI branch header */
> -               ret =3D drm_dp_dpcd_read(mgr->aux, DP_BRANCH_OUI, buf, DP=
_BRANCH_OUI_HEADER_SIZE);
> +               drm_dp_dpcd_read(mgr->aux, DP_BRANCH_OUI, buf, DP_BRANCH_=
OUI_HEADER_SIZE);
>                 seq_printf(m, "branch oui: %*phN devid: ", 3, buf);
>                 for (i =3D 0x3; i < 0x8 && buf[i]; i++)
>                         seq_printf(m, "%c", buf[i]);
> --
> 2.15.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
