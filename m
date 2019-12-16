Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 823C4C2D0CF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 08:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EC3520733
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 08:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QDsPCzZL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbfLPI2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 03:28:45 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43501 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfLPI2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 03:28:44 -0500
Received: by mail-qk1-f193.google.com with SMTP id t129so2935281qke.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 00:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qY0Fj2NS7QrS6yyqtm/6VeG23NikZuSaQjc06999aA8=;
        b=QDsPCzZLo5LcuQSUWVPUBE6JaFnUSaO+Pd/nBRfdfiMgyuaoOZgSxnRPpxezl3yTr8
         hyLF4iuz5k5izk0z2QKtziRfLedX0rHK7h0X+QP2RlWhYU9/Fyy/gFtJHQQ2VCwuY2fi
         ysadXAECvm4/57DAdKlYxjvT/bLYGmIJUUiiahk2sE7QsYPgw1gY8qdDu0qpsba0qChT
         Ps1mZJF9HaoW/jN63xogkQg9zAWDImMcUk1Y8BF8JpjNO1SuZmNpz/Pnx+/ZAzBZWNNY
         Z69zcun4CpX9meELq3o75RW7pIlKykk0XspXQw2jer2OAdPaR9JIpP9UhPhC5a0MTlU4
         gJmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qY0Fj2NS7QrS6yyqtm/6VeG23NikZuSaQjc06999aA8=;
        b=SrhyOiPHlwAYUEUI0tEj62nhO4oKtfcHpdUTTj67snZPIYIVt3yiThbc/t0WHv/i5G
         AK2eGxknXWd2if124Zk2f0gdBKkKSzdY81BJCrqxltldPIanEx0ULdD00B3sf80J9fnl
         MZwZwZaB4FoquHoiXMIV/dj9+Y8YUKFbMYzzvS9YigbAuuiwGlgZxFJbGvDXymYZLE5r
         wGaEjk603LpCT90ayXFoNfY426thpisHjmfugyWhaX64aWDO9mf3axmeFQ15j7bWtpXQ
         l1aJW97BSxFLIJUmnupmMe//LiGthuYo7KU7/TqZwNCRVH8OiMDRRWTsPm1ZItXvfWw7
         8cdw==
X-Gm-Message-State: APjAAAWnsw3TS4NphHG5H3TrH9zO986N+UN7VypcgfMs5LQBg8NXIhMm
        HAqlZ8eF/zePSNriKm5YipfmUtnM+3Je3e5nVw07PQ==
X-Google-Smtp-Source: APXvYqyhChZv5VpYCIrYP/5PKbtXGfipWyPNPVw/c0i0ohmxSk53tCM/7prPr2slbcT99kLD3Y9jl2TbXoaF3vV8Tfc=
X-Received: by 2002:a37:6087:: with SMTP id u129mr25456447qkb.219.1576484923323;
 Mon, 16 Dec 2019 00:28:43 -0800 (PST)
MIME-Version: 1.0
References: <20191128135057.20020-1-benjamin.gaignard@st.com> <878snsvxzu.fsf@intel.com>
In-Reply-To: <878snsvxzu.fsf@intel.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Mon, 16 Dec 2019 09:28:31 +0100
Message-ID: <CA+M3ks5WvYoDLSrbvaGBbJg9+nnkX=xyCiD389QD8tSCdNqB+g@mail.gmail.com>
Subject: Re: [PATCH v3] drm/dp_mst: Fix W=1 warnings
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Benjamin Gaignard <benjamin.gaignard@st.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
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

Le mer. 4 d=C3=A9c. 2019 =C3=A0 17:47, Jani Nikula <jani.nikula@linux.intel=
.com> a =C3=A9crit :
>
> On Thu, 28 Nov 2019, Benjamin Gaignard <benjamin.gaignard@st.com> wrote:
> > Fix the warnings that show up with W=3D1.
> > They are all about unused but set variables.
> > If functions returns are not used anymore make them void.
> >
> > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> > ---
> > CC: Jani Nikula <jani.nikula@linux.intel.com>
> >
> > changes in version 3:
> > - remove the hunk that may conflict with c485e2c97dae
> >   ("drm/dp_mst: Refactor pdt setup/teardown, add more locking")
> >
> > changes in version 2:
> > - fix indentations
> > - when possible change functions prototype to void
> >
> > drivers/gpu/drm/drm_dp_mst_topology.c | 83 +++++++++++++---------------=
-------
> >  1 file changed, 31 insertions(+), 52 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/dr=
m_dp_mst_topology.c
> > index 1437bc46368b..d5cb5688b5dd 100644
> > --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> > +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> > @@ -674,7 +674,6 @@ static bool drm_dp_sideband_msg_build(struct drm_dp=
_sideband_msg_rx *msg,
> >                                     u8 *replybuf, u8 replybuflen, bool =
hdr)
> >  {
> >       int ret;
> > -     u8 crc4;
> >
> >       if (hdr) {
> >               u8 hdrlen;
> > @@ -716,8 +715,6 @@ static bool drm_dp_sideband_msg_build(struct drm_dp=
_sideband_msg_rx *msg,
> >       }
> >
> >       if (msg->curchunk_idx >=3D msg->curchunk_len) {
> > -             /* do CRC */
> > -             crc4 =3D drm_dp_msg_data_crc4(msg->chunk, msg->curchunk_l=
en - 1);
>
> Again, someone needs to check if crc4 should be *used* instead of thrown
> away. Blindly throwing stuff out is not the way to go.

Hi Dave,

Your are the original writer of this code, could you tell us if we can drop=
 crc4
ao if there is something else that I have misunderstood ?

Thanks,
Benjamin

>
> BR,
> Jani.
>
> >               /* copy chunk into bigger msg */
> >               memcpy(&msg->msg[msg->curlen], msg->chunk, msg->curchunk_=
len - 1);
> >               msg->curlen +=3D msg->curchunk_len - 1;
> > @@ -1014,7 +1011,7 @@ static bool drm_dp_sideband_parse_req(struct drm_=
dp_sideband_msg_rx *raw,
> >       }
> >  }
> >
> > -static int build_dpcd_write(struct drm_dp_sideband_msg_tx *msg, u8 por=
t_num, u32 offset, u8 num_bytes, u8 *bytes)
> > +static void build_dpcd_write(struct drm_dp_sideband_msg_tx *msg, u8 po=
rt_num, u32 offset, u8 num_bytes, u8 *bytes)
> >  {
> >       struct drm_dp_sideband_msg_req_body req;
> >
> > @@ -1024,17 +1021,14 @@ static int build_dpcd_write(struct drm_dp_sideb=
and_msg_tx *msg, u8 port_num, u32
> >       req.u.dpcd_write.num_bytes =3D num_bytes;
> >       req.u.dpcd_write.bytes =3D bytes;
> >       drm_dp_encode_sideband_req(&req, msg);
> > -
> > -     return 0;
> >  }
> >
> > -static int build_link_address(struct drm_dp_sideband_msg_tx *msg)
> > +static void build_link_address(struct drm_dp_sideband_msg_tx *msg)
> >  {
> >       struct drm_dp_sideband_msg_req_body req;
> >
> >       req.req_type =3D DP_LINK_ADDRESS;
> >       drm_dp_encode_sideband_req(&req, msg);
> > -     return 0;
> >  }
> >
> >  static int build_enum_path_resources(struct drm_dp_sideband_msg_tx *ms=
g, int port_num)
> > @@ -1048,7 +1042,7 @@ static int build_enum_path_resources(struct drm_d=
p_sideband_msg_tx *msg, int por
> >       return 0;
> >  }
> >
> > -static int build_allocate_payload(struct drm_dp_sideband_msg_tx *msg, =
int port_num,
> > +static void build_allocate_payload(struct drm_dp_sideband_msg_tx *msg,=
 int port_num,
> >                                 u8 vcpi, uint16_t pbn,
> >                                 u8 number_sdp_streams,
> >                                 u8 *sdp_stream_sink)
> > @@ -1064,10 +1058,9 @@ static int build_allocate_payload(struct drm_dp_=
sideband_msg_tx *msg, int port_n
> >                  number_sdp_streams);
> >       drm_dp_encode_sideband_req(&req, msg);
> >       msg->path_msg =3D true;
> > -     return 0;
> >  }
> >
> > -static int build_power_updown_phy(struct drm_dp_sideband_msg_tx *msg,
> > +static void build_power_updown_phy(struct drm_dp_sideband_msg_tx *msg,
> >                                 int port_num, bool power_up)
> >  {
> >       struct drm_dp_sideband_msg_req_body req;
> > @@ -1080,7 +1073,6 @@ static int build_power_updown_phy(struct drm_dp_s=
ideband_msg_tx *msg,
> >       req.u.port_num.port_number =3D port_num;
> >       drm_dp_encode_sideband_req(&req, msg);
> >       msg->path_msg =3D true;
> > -     return 0;
> >  }
> >
> >  static int drm_dp_mst_assign_payload_id(struct drm_dp_mst_topology_mgr=
 *mgr,
> > @@ -1746,14 +1738,13 @@ static u8 drm_dp_calculate_rad(struct drm_dp_ms=
t_port *port,
> >   */
> >  static bool drm_dp_port_setup_pdt(struct drm_dp_mst_port *port)
> >  {
> > -     int ret;
> >       u8 rad[6], lct;
> >       bool send_link =3D false;
> >       switch (port->pdt) {
> >       case DP_PEER_DEVICE_DP_LEGACY_CONV:
> >       case DP_PEER_DEVICE_SST_SINK:
> >               /* add i2c over sideband */
> > -             ret =3D drm_dp_mst_register_i2c_bus(&port->aux);
> > +             drm_dp_mst_register_i2c_bus(&port->aux);
> >               break;
> >       case DP_PEER_DEVICE_MST_BRANCHING:
> >               lct =3D drm_dp_calculate_rad(port, rad);
> > @@ -1823,25 +1814,20 @@ ssize_t drm_dp_mst_dpcd_write(struct drm_dp_aux=
 *aux,
> >
> >  static void drm_dp_check_mstb_guid(struct drm_dp_mst_branch *mstb, u8 =
*guid)
> >  {
> > -     int ret;
> > -
> >       memcpy(mstb->guid, guid, 16);
> >
> >       if (!drm_dp_validate_guid(mstb->mgr, mstb->guid)) {
> >               if (mstb->port_parent) {
> > -                     ret =3D drm_dp_send_dpcd_write(
> > -                                     mstb->mgr,
> > -                                     mstb->port_parent,
> > -                                     DP_GUID,
> > -                                     16,
> > -                                     mstb->guid);
> > +                     drm_dp_send_dpcd_write(mstb->mgr,
> > +                                            mstb->port_parent,
> > +                                            DP_GUID,
> > +                                            16,
> > +                                            mstb->guid);
> >               } else {
> > -
> > -                     ret =3D drm_dp_dpcd_write(
> > -                                     mstb->mgr->aux,
> > -                                     DP_GUID,
> > -                                     mstb->guid,
> > -                                     16);
> > +                     drm_dp_dpcd_write(mstb->mgr->aux,
> > +                                       DP_GUID,
> > +                                       mstb->guid,
> > +                                       16);
> >               }
> >       }
> >  }
> > @@ -2197,7 +2183,7 @@ static bool drm_dp_validate_guid(struct drm_dp_ms=
t_topology_mgr *mgr,
> >       return false;
> >  }
> >
> > -static int build_dpcd_read(struct drm_dp_sideband_msg_tx *msg, u8 port=
_num, u32 offset, u8 num_bytes)
> > +static void build_dpcd_read(struct drm_dp_sideband_msg_tx *msg, u8 por=
t_num, u32 offset, u8 num_bytes)
> >  {
> >       struct drm_dp_sideband_msg_req_body req;
> >
> > @@ -2206,8 +2192,6 @@ static int build_dpcd_read(struct drm_dp_sideband=
_msg_tx *msg, u8 port_num, u32
> >       req.u.dpcd_read.dpcd_address =3D offset;
> >       req.u.dpcd_read.num_bytes =3D num_bytes;
> >       drm_dp_encode_sideband_req(&req, msg);
> > -
> > -     return 0;
> >  }
> >
> >  static int drm_dp_send_sideband_msg(struct drm_dp_mst_topology_mgr *mg=
r,
> > @@ -2429,14 +2413,14 @@ static void drm_dp_send_link_address(struct drm=
_dp_mst_topology_mgr *mgr,
> >  {
> >       struct drm_dp_sideband_msg_tx *txmsg;
> >       struct drm_dp_link_address_ack_reply *reply;
> > -     int i, len, ret;
> > +     int i, ret;
> >
> >       txmsg =3D kzalloc(sizeof(*txmsg), GFP_KERNEL);
> >       if (!txmsg)
> >               return;
> >
> >       txmsg->dst =3D mstb;
> > -     len =3D build_link_address(txmsg);
> > +     build_link_address(txmsg);
> >
> >       mstb->link_address_sent =3D true;
> >       drm_dp_queue_down_tx(mgr, txmsg);
> > @@ -2478,7 +2462,6 @@ drm_dp_send_enum_path_resources(struct drm_dp_mst=
_topology_mgr *mgr,
> >  {
> >       struct drm_dp_enum_path_resources_ack_reply *path_res;
> >       struct drm_dp_sideband_msg_tx *txmsg;
> > -     int len;
> >       int ret;
> >
> >       txmsg =3D kzalloc(sizeof(*txmsg), GFP_KERNEL);
> > @@ -2486,7 +2469,7 @@ drm_dp_send_enum_path_resources(struct drm_dp_mst=
_topology_mgr *mgr,
> >               return -ENOMEM;
> >
> >       txmsg->dst =3D mstb;
> > -     len =3D build_enum_path_resources(txmsg, port->port_num);
> > +     build_enum_path_resources(txmsg, port->port_num);
> >
> >       drm_dp_queue_down_tx(mgr, txmsg);
> >
> > @@ -2569,7 +2552,7 @@ static int drm_dp_payload_send_msg(struct drm_dp_=
mst_topology_mgr *mgr,
> >  {
> >       struct drm_dp_sideband_msg_tx *txmsg;
> >       struct drm_dp_mst_branch *mstb;
> > -     int len, ret, port_num;
> > +     int ret, port_num;
> >       u8 sinks[DRM_DP_MAX_SDP_STREAMS];
> >       int i;
> >
> > @@ -2594,9 +2577,9 @@ static int drm_dp_payload_send_msg(struct drm_dp_=
mst_topology_mgr *mgr,
> >               sinks[i] =3D i;
> >
> >       txmsg->dst =3D mstb;
> > -     len =3D build_allocate_payload(txmsg, port_num,
> > -                                  id,
> > -                                  pbn, port->num_sdp_streams, sinks);
> > +     build_allocate_payload(txmsg, port_num,
> > +                            id,
> > +                            pbn, port->num_sdp_streams, sinks);
> >
> >       drm_dp_queue_down_tx(mgr, txmsg);
> >
> > @@ -2625,7 +2608,7 @@ int drm_dp_send_power_updown_phy(struct drm_dp_ms=
t_topology_mgr *mgr,
> >                                struct drm_dp_mst_port *port, bool power=
_up)
> >  {
> >       struct drm_dp_sideband_msg_tx *txmsg;
> > -     int len, ret;
> > +     int ret;
> >
> >       port =3D drm_dp_mst_topology_get_port_validated(mgr, port);
> >       if (!port)
> > @@ -2638,7 +2621,7 @@ int drm_dp_send_power_updown_phy(struct drm_dp_ms=
t_topology_mgr *mgr,
> >       }
> >
> >       txmsg->dst =3D port->parent;
> > -     len =3D build_power_updown_phy(txmsg, port->port_num, power_up);
> > +     build_power_updown_phy(txmsg, port->port_num, power_up);
> >       drm_dp_queue_down_tx(mgr, txmsg);
> >
> >       ret =3D drm_dp_mst_wait_tx_reply(port->parent, txmsg);
> > @@ -2858,7 +2841,6 @@ static int drm_dp_send_dpcd_read(struct drm_dp_ms=
t_topology_mgr *mgr,
> >                                struct drm_dp_mst_port *port,
> >                                int offset, int size, u8 *bytes)
> >  {
> > -     int len;
> >       int ret =3D 0;
> >       struct drm_dp_sideband_msg_tx *txmsg;
> >       struct drm_dp_mst_branch *mstb;
> > @@ -2873,7 +2855,7 @@ static int drm_dp_send_dpcd_read(struct drm_dp_ms=
t_topology_mgr *mgr,
> >               goto fail_put;
> >       }
> >
> > -     len =3D build_dpcd_read(txmsg, port->port_num, offset, size);
> > +     build_dpcd_read(txmsg, port->port_num, offset, size);
> >       txmsg->dst =3D port->parent;
> >
> >       drm_dp_queue_down_tx(mgr, txmsg);
> > @@ -2911,7 +2893,6 @@ static int drm_dp_send_dpcd_write(struct drm_dp_m=
st_topology_mgr *mgr,
> >                                 struct drm_dp_mst_port *port,
> >                                 int offset, int size, u8 *bytes)
> >  {
> > -     int len;
> >       int ret;
> >       struct drm_dp_sideband_msg_tx *txmsg;
> >       struct drm_dp_mst_branch *mstb;
> > @@ -2926,7 +2907,7 @@ static int drm_dp_send_dpcd_write(struct drm_dp_m=
st_topology_mgr *mgr,
> >               goto fail_put;
> >       }
> >
> > -     len =3D build_dpcd_write(txmsg, port->port_num, offset, size, byt=
es);
> > +     build_dpcd_write(txmsg, port->port_num, offset, size, bytes);
> >       txmsg->dst =3D mstb;
> >
> >       drm_dp_queue_down_tx(mgr, txmsg);
> > @@ -3149,7 +3130,7 @@ static bool drm_dp_get_one_sb_msg(struct drm_dp_m=
st_topology_mgr *mgr, bool up)
> >  {
> >       int len;
> >       u8 replyblock[32];
> > -     int replylen, origlen, curreply;
> > +     int replylen, curreply;
> >       int ret;
> >       struct drm_dp_sideband_msg_rx *msg;
> >       int basereg =3D up ? DP_SIDEBAND_MSG_UP_REQ_BASE : DP_SIDEBAND_MS=
G_DOWN_REP_BASE;
> > @@ -3169,7 +3150,6 @@ static bool drm_dp_get_one_sb_msg(struct drm_dp_m=
st_topology_mgr *mgr, bool up)
> >       }
> >       replylen =3D msg->curchunk_len + msg->curchunk_hdrlen;
> >
> > -     origlen =3D replylen;
> >       replylen -=3D len;
> >       curreply =3D len;
> >       while (replylen > 0) {
> > @@ -3961,17 +3941,16 @@ void drm_dp_mst_dump_topology(struct seq_file *=
m,
> >       mutex_lock(&mgr->lock);
> >       if (mgr->mst_primary) {
> >               u8 buf[DP_PAYLOAD_TABLE_SIZE];
> > -             int ret;
> >
> > -             ret =3D drm_dp_dpcd_read(mgr->aux, DP_DPCD_REV, buf, DP_R=
ECEIVER_CAP_SIZE);
> > +             drm_dp_dpcd_read(mgr->aux, DP_DPCD_REV, buf, DP_RECEIVER_=
CAP_SIZE);
> >               seq_printf(m, "dpcd: %*ph\n", DP_RECEIVER_CAP_SIZE, buf);
> > -             ret =3D drm_dp_dpcd_read(mgr->aux, DP_FAUX_CAP, buf, 2);
> > +             drm_dp_dpcd_read(mgr->aux, DP_FAUX_CAP, buf, 2);
> >               seq_printf(m, "faux/mst: %*ph\n", 2, buf);
> > -             ret =3D drm_dp_dpcd_read(mgr->aux, DP_MSTM_CTRL, buf, 1);
> > +             drm_dp_dpcd_read(mgr->aux, DP_MSTM_CTRL, buf, 1);
> >               seq_printf(m, "mst ctrl: %*ph\n", 1, buf);
> >
> >               /* dump the standard OUI branch header */
> > -             ret =3D drm_dp_dpcd_read(mgr->aux, DP_BRANCH_OUI, buf, DP=
_BRANCH_OUI_HEADER_SIZE);
> > +             drm_dp_dpcd_read(mgr->aux, DP_BRANCH_OUI, buf, DP_BRANCH_=
OUI_HEADER_SIZE);
> >               seq_printf(m, "branch oui: %*phN devid: ", 3, buf);
> >               for (i =3D 0x3; i < 0x8 && buf[i]; i++)
> >                       seq_printf(m, "%c", buf[i]);
>
> --
> Jani Nikula, Intel Open Source Graphics Center
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
