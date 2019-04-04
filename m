Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75063C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 12:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0987420855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 12:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="AbdOrYO0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729777AbfDDMiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 08:38:51 -0400
Received: from alln-iport-8.cisco.com ([173.37.142.95]:29956 "EHLO
        alln-iport-8.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727525AbfDDMiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 08:38:50 -0400
X-Greylist: delayed 425 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Apr 2019 08:38:46 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=41874; q=dns/txt;
  s=iport; t=1554381528; x=1555591128;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=gGeuuNhmQKmhXwbT75lvUvY2YOlugpOwA9HSfLbh1y0=;
  b=AbdOrYO0siNkulBlPdgsfySKog+FOnBQ9d9ILdhRwX75rcEQeBY4eexm
   pxm1NKyGncxnTVnPQyWrJRK+NnY7yC6wGHI2b/Zh+HyGgD7lurUIFeeMi
   Eu1Gn5RRYh/WzIxx6KjnO1a82GwKWsbu7h3Rs1cW/choIPoTuX1NQwd/X
   Y=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0ADAAAB+KVc/5BdJa1lGQEBAQEBAQE?=
 =?us-ascii?q?BAQEBAQcBAQEBAQGBUQQBAQEBAQsBghBogQMnCowgixmCDX6HKJAdgXsOAQE?=
 =?us-ascii?q?bhFGFTiI0CQ0BAQMBAQkBAwJtHAyFSgEBAQQaAR8/EAIBCBUDHhAyJQIEAQ0?=
 =?us-ascii?q?FCIMbgXWuZ4QFAYYygTABizIXgUA/gRABgl01PoQNNyaFOwOKMYIthHOHQox?=
 =?us-ascii?q?VCQKMGodWIpROi06TcAIRFYEwHziBVnAVGiGCbAmCCgMXFIMQikQBNkExjhi?=
 =?us-ascii?q?BLoEfAQE?=
X-IronPort-AV: E=Sophos;i="5.60,308,1549929600"; 
   d="scan'208";a="255127654"
Received: from rcdn-core-8.cisco.com ([173.37.93.144])
  by alln-iport-8.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 04 Apr 2019 12:31:40 +0000
Received: from XCH-ALN-013.cisco.com (xch-aln-013.cisco.com [173.36.7.23])
        by rcdn-core-8.cisco.com (8.15.2/8.15.2) with ESMTPS id x34CVeOD006577
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 4 Apr 2019 12:31:40 GMT
Received: from xch-aln-012.cisco.com (173.36.7.22) by XCH-ALN-013.cisco.com
 (173.36.7.23) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 4 Apr
 2019 07:31:39 -0500
Received: from xch-aln-012.cisco.com ([173.36.7.22]) by XCH-ALN-012.cisco.com
 ([173.36.7.22]) with mapi id 15.00.1473.003; Thu, 4 Apr 2019 07:31:39 -0500
From:   "Hans Verkuil (hansverk)" <hansverk@cisco.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        "hans.verkuil@cisco.com" <hans.verkuil@cisco.com>,
        "acourbot@chromium.org" <acourbot@chromium.org>,
        "sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>,
        "Laurent Pinchart" <laurent.pinchart@ideasonboard.com>
CC:     "tfiga@chromium.org" <tfiga@chromium.org>,
        "posciak@chromium.org" <posciak@chromium.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "nicolas.dufresne@collabora.com" <nicolas.dufresne@collabora.com>,
        "jenskuske@gmail.com" <jenskuske@gmail.com>,
        "jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>,
        "jonas@kwiboo.se" <jonas@kwiboo.se>,
        "ezequiel@collabora.com" <ezequiel@collabora.com>,
        "linux-sunxi@googlegroups.com" <linux-sunxi@googlegroups.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH RESEND v7 1/2] media: uapi: Add H264 low-level decoder API
 compound controls.
Thread-Topic: [PATCH RESEND v7 1/2] media: uapi: Add H264 low-level decoder
 API compound controls.
Thread-Index: AQHU6uGe8886f4JJ7EGVwr+En41ldg==
Date:   Thu, 4 Apr 2019 12:31:39 +0000
Message-ID: <56d851685aa9425398b8a3e8f036de6a@XCH-ALN-012.cisco.com>
References: <cover.bfe197a82766125bea21dd26fd3de85893a921ac.1554380738.git-series.maxime.ripard@bootlin.com>
 <7cd913545cfc80fa9999839c62c4bf7b354a7904.1554380738.git-series.maxime.ripard@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.47.79.183]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Outbound-SMTP-Client: 173.36.7.23, xch-aln-013.cisco.com
X-Outbound-Node: rcdn-core-8.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/19 2:26 PM, Maxime Ripard wrote:=0A=
> From: Pawel Osciak <posciak@chromium.org>=0A=
> =0A=
> Stateless video codecs will require both the H264 metadata and slices in=
=0A=
> order to be able to decode frames.=0A=
> =0A=
> This introduces the definitions for a new pixel format for H264 slices th=
at=0A=
> have been parsed, as well as the structures used to pass the metadata fro=
m=0A=
> the userspace to the kernel.=0A=
> =0A=
> Reviewed-by: Tomasz Figa <tfiga@chromium.org>=0A=
> Signed-off-by: Pawel Osciak <posciak@chromium.org>=0A=
> Signed-off-by: Guenter Roeck <groeck@chromium.org>=0A=
> Co-developed-by: Maxime Ripard <maxime.ripard@bootlin.com>=0A=
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>=0A=
> ---=0A=
>  Documentation/media/uapi/v4l/biblio.rst            |   9 +-=0A=
>  Documentation/media/uapi/v4l/ext-ctrls-codec.rst   | 569 ++++++++++++++-=
=0A=
>  Documentation/media/uapi/v4l/pixfmt-compressed.rst |  19 +-=0A=
>  Documentation/media/uapi/v4l/vidioc-queryctrl.rst  |  30 +-=0A=
>  Documentation/media/videodev2.h.rst.exceptions     |   5 +-=0A=
>  drivers/media/v4l2-core/v4l2-ctrls.c               |  42 +-=0A=
>  drivers/media/v4l2-core/v4l2-ioctl.c               |   1 +-=0A=
>  include/media/h264-ctrls.h                         | 192 +++++-=0A=
>  include/media/v4l2-ctrls.h                         |  13 +-=0A=
>  include/uapi/linux/videodev2.h                     |   1 +-=0A=
>  10 files changed, 880 insertions(+), 1 deletion(-)=0A=
>  create mode 100644 include/media/h264-ctrls.h=0A=
> =0A=
> diff --git a/Documentation/media/uapi/v4l/biblio.rst b/Documentation/medi=
a/uapi/v4l/biblio.rst=0A=
> index ec33768c055e..8f4eb8823d82 100644=0A=
> --- a/Documentation/media/uapi/v4l/biblio.rst=0A=
> +++ b/Documentation/media/uapi/v4l/biblio.rst=0A=
> @@ -122,6 +122,15 @@ ITU BT.1119=0A=
>  =0A=
>  :author:    International Telecommunication Union (http://www.itu.ch)=0A=
>  =0A=
> +.. _h264:=0A=
> +=0A=
> +ITU-T Rec. H.264 Specification (04/2017 Edition)=0A=
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
> +=0A=
> +:title:     ITU-T Recommendation H.264 "Advanced Video Coding for Generi=
c Audiovisual Services"=0A=
> +=0A=
> +:author:    International Telecommunication Union (http://www.itu.ch)=0A=
> +=0A=
>  .. _jfif:=0A=
>  =0A=
>  JFIF=0A=
> diff --git a/Documentation/media/uapi/v4l/ext-ctrls-codec.rst b/Documenta=
tion/media/uapi/v4l/ext-ctrls-codec.rst=0A=
> index 67a122339c0e..1285bfec7d3d 100644=0A=
> --- a/Documentation/media/uapi/v4l/ext-ctrls-codec.rst=0A=
> +++ b/Documentation/media/uapi/v4l/ext-ctrls-codec.rst=0A=
> @@ -1371,6 +1371,575 @@ enum v4l2_mpeg_video_h264_hierarchical_coding_typ=
e -=0A=
>        - Layer number=0A=
>  =0A=
>  =0A=
> +.. _v4l2-mpeg-h264:=0A=
> +=0A=
> +``V4L2_CID_MPEG_VIDEO_H264_SPS (struct)``=0A=
> +    Specifies the sequence parameter set (as extracted from the=0A=
> +    bitstream) for the associated H264 slice data. This includes the=0A=
> +    necessary parameters for configuring a stateless hardware decoding=
=0A=
> +    pipeline for H264. The bitstream parameters are defined according=0A=
> +    to :ref:`h264`, section 7.4.2.1.1 "Sequence Parameter Set Data=0A=
> +    Semantics". For further documentation, refer to the above=0A=
> +    specification, unless there is an explicit comment stating=0A=
> +    otherwise.=0A=
> +=0A=
> +    .. note::=0A=
> +=0A=
> +       This compound control is not yet part of the public kernel API an=
d=0A=
> +       it is expected to change.=0A=
> +=0A=
> +.. c:type:: v4l2_ctrl_h264_sps=0A=
> +=0A=
> +.. cssclass:: longtable=0A=
> +=0A=
> +.. flat-table:: struct v4l2_ctrl_h264_sps=0A=
> +    :header-rows:  0=0A=
> +    :stub-columns: 0=0A=
> +    :widths:       1 1 2=0A=
> +=0A=
> +    * - __u8=0A=
> +      - ``profile_idc``=0A=
> +      -=0A=
> +    * - __u8=0A=
> +      - ``constraint_set_flags``=0A=
> +      - See :ref:`Sequence Parameter Set Constraints Set Flags <h264_sps=
_constraints_set_flags>`=0A=
> +    * - __u8=0A=
> +      - ``level_idc``=0A=
> +      -=0A=
> +    * - __u8=0A=
> +      - ``seq_parameter_set_id``=0A=
> +      -=0A=
> +    * - __u8=0A=
> +      - ``chroma_format_idc``=0A=
> +      -=0A=
> +    * - __u8=0A=
> +      - ``bit_depth_luma_minus8``=0A=
> +      -=0A=
> +    * - __u8=0A=
> +      - ``bit_depth_chroma_minus8``=0A=
> +      -=0A=
> +    * - __u8=0A=
> +      - ``log2_max_frame_num_minus4``=0A=
> +      -=0A=
> +    * - __u8=0A=
> +      - ``pic_order_cnt_type``=0A=
> +      -=0A=
> +    * - __u8=0A=
> +      - ``log2_max_pic_order_cnt_lsb_minus4``=0A=
> +      -=0A=
> +    * - __u8=0A=
> +      - ``max_num_ref_frames``=0A=
> +      -=0A=
> +    * - __u8=0A=
> +      - ``num_ref_frames_in_pic_order_cnt_cycle``=0A=
> +      -=0A=
> +    * - __s32=0A=
> +      - ``offset_for_ref_frame[255]``=0A=
> +      -=0A=
> +    * - __s32=0A=
> +      - ``offset_for_non_ref_pic``=0A=
> +      -=0A=
> +    * - __s32=0A=
> +      - ``offset_for_top_to_bottom_field``=0A=
> +      -=0A=
> +    * - __u16=0A=
> +      - ``pic_width_in_mbs_minus1``=0A=
> +      -=0A=
> +    * - __u16=0A=
> +      - ``pic_height_in_map_units_minus1``=0A=
> +      -=0A=
> +    * - __u32=0A=
> +      - ``flags``=0A=
> +      - See :ref:`Sequence Parameter Set Flags <h264_sps_flags>`=0A=
> +=0A=
> +.. _h264_sps_constraints_set_flags:=0A=
> +=0A=
> +``Sequence Parameter Set Constraints Set Flags``=0A=
> +=0A=
> +.. cssclass:: longtable=0A=
> +=0A=
> +.. flat-table::=0A=
> +    :header-rows:  0=0A=
> +    :stub-columns: 0=0A=
> +    :widths:       1 1 2=0A=
> +=0A=
> +    * - ``V4L2_H264_SPS_CONSTRAINT_SET0_FLAG``=0A=
> +      - 0x00000001=0A=
> +      -=0A=
> +    * - ``V4L2_H264_SPS_CONSTRAINT_SET1_FLAG``=0A=
> +      - 0x00000002=0A=
> +      -=0A=
> +    * - ``V4L2_H264_SPS_CONSTRAINT_SET2_FLAG``=0A=
> +      - 0x00000004=0A=
> +      -=0A=
> +    * - ``V4L2_H264_SPS_CONSTRAINT_SET3_FLAG``=0A=
> +      - 0x00000008=0A=
> +      -=0A=
> +    * - ``V4L2_H264_SPS_CONSTRAINT_SET4_FLAG``=0A=
> +      - 0x00000010=0A=
> +      -=0A=
> +    * - ``V4L2_H264_SPS_CONSTRAINT_SET5_FLAG``=0A=
> +      - 0x00000020=0A=
> +      -=0A=
> +=0A=
> +.. _h264_sps_flags:=0A=
> +=0A=
> +``Sequence Parameter Set Flags``=0A=
> +=0A=
> +.. cssclass:: longtable=0A=
> +=0A=
> +.. flat-table::=0A=
> +    :header-rows:  0=0A=
> +    :stub-columns: 0=0A=
> +    :widths:       1 1 2=0A=
> +=0A=
> +    * - ``V4L2_H264_SPS_FLAG_SEPARATE_COLOUR_PLANE``=0A=
> +      - 0x00000001=0A=
> +      -=0A=
> +    * - ``V4L2_H264_SPS_FLAG_QPPRIME_Y_ZERO_TRANSFORM_BYPASS``=0A=
> +      - 0x00000002=0A=
> +      -=0A=
> +    * - ``V4L2_H264_SPS_FLAG_DELTA_PIC_ORDER_ALWAYS_ZERO``=0A=
> +      - 0x00000004=0A=
> +      -=0A=
> +    * - ``V4L2_H264_SPS_FLAG_GAPS_IN_FRAME_NUM_VALUE_ALLOWED``=0A=
> +      - 0x00000008=0A=
> +      -=0A=
> +    * - ``V4L2_H264_SPS_FLAG_FRAME_MBS_ONLY``=0A=
> +      - 0x00000010=0A=
> +      -=0A=
> +    * - ``V4L2_H264_SPS_FLAG_MB_ADAPTIVE_FRAME_FIELD``=0A=
> +      - 0x00000020=0A=
> +      -=0A=
> +    * - ``V4L2_H264_SPS_FLAG_DIRECT_8X8_INFERENCE``=0A=
> +      - 0x00000040=0A=
> +      -=0A=
> +=0A=
> +``V4L2_CID_MPEG_VIDEO_H264_PPS (struct)``=0A=
> +    Specifies the picture parameter set (as extracted from the=0A=
> +    bitstream) for the associated H264 slice data. This includes the=0A=
> +    necessary parameters for configuring a stateless hardware decoding=
=0A=
> +    pipeline for H264.  The bitstream parameters are defined according=
=0A=
> +    to :ref:`h264`, section 7.4.2.2 "Picture Parameter Set RBSP=0A=
> +    Semantics". For further documentation, refer to the above=0A=
> +    specification, unless there is an explicit comment stating=0A=
> +    otherwise.=0A=
> +=0A=
> +    .. note::=0A=
> +=0A=
> +       This compound control is not yet part of the public kernel API an=
d=0A=
> +       it is expected to change.=0A=
> +=0A=
> +.. c:type:: v4l2_ctrl_h264_pps=0A=
> +=0A=
> +.. cssclass:: longtable=0A=
> +=0A=
> +.. flat-table:: struct v4l2_ctrl_h264_pps=0A=
> +    :header-rows:  0=0A=
> +    :stub-columns: 0=0A=
> +    :widths:       1 1 2=0A=
> +=0A=
> +    * - __u8=0A=
> +      - ``pic_parameter_set_id``=0A=
> +      -=0A=
> +    * - __u8=0A=
> +      - ``seq_parameter_set_id``=0A=
> +      -=0A=
> +    * - __u8=0A=
> +      - ``num_slice_groups_minus1``=0A=
> +      -=0A=
> +    * - __u8=0A=
> +      - ``num_ref_idx_l0_default_active_minus1``=0A=
> +      -=0A=
> +    * - __u8=0A=
> +      - ``num_ref_idx_l1_default_active_minus1``=0A=
> +      -=0A=
> +    * - __u8=0A=
> +      - ``weighted_bipred_idc``=0A=
> +      -=0A=
> +    * - __s8=0A=
> +      - ``pic_init_qp_minus26``=0A=
> +      -=0A=
> +    * - __s8=0A=
> +      - ``pic_init_qs_minus26``=0A=
> +      -=0A=
> +    * - __s8=0A=
> +      - ``chroma_qp_index_offset``=0A=
> +      -=0A=
> +    * - __s8=0A=
> +      - ``second_chroma_qp_index_offset``=0A=
> +      -=0A=
> +    * - __u16=0A=
> +      - ``flags``=0A=
> +      - See :ref:`Picture Parameter Set Flags <h264_pps_flags>`=0A=
> +=0A=
> +.. _h264_pps_flags:=0A=
> +=0A=
> +``Picture Parameter Set Flags``=0A=
> +=0A=
> +.. cssclass:: longtable=0A=
> +=0A=
> +.. flat-table::=0A=
> +    :header-rows:  0=0A=
> +    :stub-columns: 0=0A=
> +    :widths:       1 1 2=0A=
> +=0A=
> +    * - ``V4L2_H264_PPS_FLAG_ENTROPY_CODING_MODE``=0A=
> +      - 0x00000001=0A=
> +      -=0A=
> +    * - ``V4L2_H264_PPS_FLAG_BOTTOM_FIELD_PIC_ORDER_IN_FRAME_PRESENT``=
=0A=
> +      - 0x00000002=0A=
> +      -=0A=
> +    * - ``V4L2_H264_PPS_FLAG_WEIGHTED_PRED``=0A=
> +      - 0x00000004=0A=
> +      -=0A=
> +    * - ``V4L2_H264_PPS_FLAG_DEBLOCKING_FILTER_CONTROL_PRESENT``=0A=
> +      - 0x00000008=0A=
> +      -=0A=
> +    * - ``V4L2_H264_PPS_FLAG_CONSTRAINED_INTRA_PRED``=0A=
> +      - 0x00000010=0A=
> +      -=0A=
> +    * - ``V4L2_H264_PPS_FLAG_REDUNDANT_PIC_CNT_PRESENT``=0A=
> +      - 0x00000020=0A=
> +      -=0A=
> +    * - ``V4L2_H264_PPS_FLAG_TRANSFORM_8X8_MODE``=0A=
> +      - 0x00000040=0A=
> +      -=0A=
> +    * - ``V4L2_H264_PPS_FLAG_PIC_SCALING_MATRIX_PRESENT``=0A=
> +      - 0x00000080=0A=
> +      -=0A=
> +=0A=
> +``V4L2_CID_MPEG_VIDEO_H264_SCALING_MATRIX (struct)``=0A=
> +    Specifies the scaling matrix (as extracted from the bitstream) for=
=0A=
> +    the associated H264 slice data. The bitstream parameters are=0A=
> +    defined according to :ref:`h264`, section 7.4.2.1.1.1 "Scaling=0A=
> +    List Semantics".For further documentation, refer to the above=0A=
> +    specification, unless there is an explicit comment stating=0A=
> +    otherwise.=0A=
> +=0A=
> +    .. note::=0A=
> +=0A=
> +       This compound control is not yet part of the public kernel API an=
d=0A=
> +       it is expected to change.=0A=
> +=0A=
> +.. c:type:: v4l2_ctrl_h264_scaling_matrix=0A=
> +=0A=
> +.. cssclass:: longtable=0A=
> +=0A=
> +.. flat-table:: struct v4l2_ctrl_h264_scaling_matrix=0A=
> +    :header-rows:  0=0A=
> +    :stub-columns: 0=0A=
> +    :widths:       1 1 2=0A=
> +=0A=
> +    * - __u8=0A=
> +      - ``scaling_list_4x4[6][16]``=0A=
> +      -=0A=
> +    * - __u8=0A=
> +      - ``scaling_list_8x8[6][64]``=0A=
> +      -=0A=
> +=0A=
> +``V4L2_CID_MPEG_VIDEO_H264_SLICE_PARAMS (struct)``=0A=
> +    Specifies the slice parameters (as extracted from the bitstream)=0A=
> +    for the associated H264 slice data. This includes the necessary=0A=
> +    parameters for configuring a stateless hardware decoding pipeline=0A=
> +    for H264.  The bitstream parameters are defined according to=0A=
> +    :ref:`h264`, section 7.4.3 "Slice Header Semantics". For further=0A=
> +    documentation, refer to the above specification, unless there is=0A=
> +    an explicit comment stating otherwise.=0A=
> +=0A=
> +    .. note::=0A=
> +=0A=
> +       This compound control is not yet part of the public kernel API=0A=
> +       and it is expected to change.=0A=
> +=0A=
> +       This structure is expected to be passed as an array, with one=0A=
> +       entry for each slice included in the bitstream buffer.=0A=
> +=0A=
> +.. c:type:: v4l2_ctrl_h264_slice_param=0A=
=0A=
The control is called _PARAMS, yet the struct is called _param.=0A=
Same for DECODE_PARAMS.=0A=
=0A=
Can you rename the structs and anything else that has the same problem to _=
params?=0A=
=0A=
This mismatch is confusing. MPEG2 uses _params, and I think we should do th=
e same=0A=
for H.264.=0A=
=0A=
Sorry, I hadn't noticed this in earlier reviews.=0A=
=0A=
Regards,=0A=
=0A=
	Hans=0A=
=0A=
> +=0A=
> +.. cssclass:: longtable=0A=
> +=0A=
> +.. flat-table:: struct v4l2_ctrl_h264_slice_param=0A=
> +    :header-rows:  0=0A=
> +    :stub-columns: 0=0A=
> +    :widths:       1 1 2=0A=
> +=0A=
> +    * - __u32=0A=
> +      - ``size``=0A=
> +      -=0A=
> +    * - __u32=0A=
> +      - ``header_bit_size``=0A=
> +      -=0A=
> +    * - __u16=0A=
> +      - ``first_mb_in_slice``=0A=
> +      -=0A=
> +    * - __u8=0A=
> +      - ``slice_type``=0A=
> +      -=0A=
> +    * - __u8=0A=
> +      - ``pic_parameter_set_id``=0A=
> +      -=0A=
> +    * - __u8=0A=
> +      - ``colour_plane_id``=0A=
> +      -=0A=
> +    * - __u8=0A=
> +      - ``redundant_pic_cnt``=0A=
> +      -=0A=
> +    * - __u16=0A=
> +      - ``frame_num``=0A=
> +      -=0A=
> +    * - __u16=0A=
> +      - ``idr_pic_id``=0A=
> +      -=0A=
> +    * - __u16=0A=
> +      - ``pic_order_cnt_lsb``=0A=
> +      -=0A=
> +    * - __s32=0A=
> +      - ``delta_pic_order_cnt_bottom``=0A=
> +      -=0A=
> +    * - __s32=0A=
> +      - ``delta_pic_order_cnt0``=0A=
> +      -=0A=
> +    * - __s32=0A=
> +      - ``delta_pic_order_cnt1``=0A=
> +      -=0A=
> +    * - struct :c:type:`v4l2_h264_pred_weight_table`=0A=
> +      - ``pred_weight_table``=0A=
> +      -=0A=
> +    * - __u32=0A=
> +      - ``dec_ref_pic_marking_bit_size``=0A=
> +      -=0A=
> +    * - __u32=0A=
> +      - ``pic_order_cnt_bit_size``=0A=
> +      -=0A=
> +    * - __u8=0A=
> +      - ``cabac_init_idc``=0A=
> +      -=0A=
> +    * - __s8=0A=
> +      - ``slice_qp_delta``=0A=
> +      -=0A=
> +    * - __s8=0A=
> +      - ``slice_qs_delta``=0A=
> +      -=0A=
> +    * - __u8=0A=
> +      - ``disable_deblocking_filter_idc``=0A=
> +      -=0A=
> +    * - __s8=0A=
> +      - ``slice_alpha_c0_offset_div2``=0A=
> +      -=0A=
> +    * - __s8=0A=
> +      - ``slice_beta_offset_div2``=0A=
> +      -=0A=
> +    * - __u8=0A=
> +      - ``num_ref_idx_l0_active_minus1``=0A=
> +      -=0A=
> +    * - __u8=0A=
> +      - ``num_ref_idx_l1_active_minus1``=0A=
> +      -=0A=
> +    * - __u32=0A=
> +      - ``slice_group_change_cycle``=0A=
> +      -=0A=
> +    * - __u8=0A=
> +      - ``ref_pic_list0[32]``=0A=
> +      - Reference picture list after applying the per-slice modification=
s=0A=
> +    * - __u8=0A=
> +      - ``ref_pic_list1[32]``=0A=
> +      - Reference picture list after applying the per-slice modification=
s=0A=
> +    * - __u32=0A=
> +      - ``flags``=0A=
> +      - See :ref:`Slice Parameter Flags <h264_slice_flags>`=0A=
> +=0A=
> +.. _h264_slice_flags:=0A=
> +=0A=
> +``Slice Parameter Set Flags``=0A=
> +=0A=
> +.. cssclass:: longtable=0A=
> +=0A=
> +.. flat-table::=0A=
> +    :header-rows:  0=0A=
> +    :stub-columns: 0=0A=
> +    :widths:       1 1 2=0A=
> +=0A=
> +    * - ``V4L2_H264_SLICE_FLAG_FIELD_PIC``=0A=
> +      - 0x00000001=0A=
> +      -=0A=
> +    * - ``V4L2_H264_SLICE_FLAG_BOTTOM_FIELD``=0A=
> +      - 0x00000002=0A=
> +      -=0A=
> +    * - ``V4L2_H264_SLICE_FLAG_DIRECT_SPATIAL_MV_PRED``=0A=
> +      - 0x00000004=0A=
> +      -=0A=
> +    * - ``V4L2_H264_SLICE_FLAG_SP_FOR_SWITCH``=0A=
> +      - 0x00000008=0A=
> +      -=0A=
> +=0A=
> +``Prediction Weight Table``=0A=
> +=0A=
> +    The bitstream parameters are defined according to :ref:`h264`,=0A=
> +    section 7.4.3.2 "Prediction Weight Table Semantics". For further=0A=
> +    documentation, refer to the above specification, unless there is=0A=
> +    an explicit comment stating otherwise.=0A=
> +=0A=
> +.. c:type:: v4l2_h264_pred_weight_table=0A=
> +=0A=
> +.. cssclass:: longtable=0A=
> +=0A=
> +.. flat-table:: struct v4l2_h264_pred_weight_table=0A=
> +    :header-rows:  0=0A=
> +    :stub-columns: 0=0A=
> +    :widths:       1 1 2=0A=
> +=0A=
> +    * - __u16=0A=
> +      - ``luma_log2_weight_denom``=0A=
> +      -=0A=
> +    * - __u16=0A=
> +      - ``chroma_log2_weight_denom``=0A=
> +      -=0A=
> +    * - struct :c:type:`v4l2_h264_weight_factors`=0A=
> +      - ``weight_factors[2]``=0A=
> +      - The weight factors at index 0 are the weight factors for the ref=
erence=0A=
> +        list 0, the one at index 1 for the reference list 1.=0A=
> +=0A=
> +.. c:type:: v4l2_h264_weight_factors=0A=
> +=0A=
> +.. cssclass:: longtable=0A=
> +=0A=
> +.. flat-table:: struct v4l2_h264_weight_factors=0A=
> +    :header-rows:  0=0A=
> +    :stub-columns: 0=0A=
> +    :widths:       1 1 2=0A=
> +=0A=
> +    * - __s16=0A=
> +      - ``luma_weight[32]``=0A=
> +      -=0A=
> +    * - __s16=0A=
> +      - ``luma_offset[32]``=0A=
> +      -=0A=
> +    * - __s16=0A=
> +      - ``chroma_weight[32][2]``=0A=
> +      -=0A=
> +    * - __s16=0A=
> +      - ``chroma_offset[32][2]``=0A=
> +      -=0A=
> +=0A=
> +``V4L2_CID_MPEG_VIDEO_H264_DECODE_PARAMS (struct)``=0A=
> +    Specifies the decode parameters (as extracted from the bitstream)=0A=
> +    for the associated H264 slice data. This includes the necessary=0A=
> +    parameters for configuring a stateless hardware decoding pipeline=0A=
> +    for H264. The bitstream parameters are defined according to=0A=
> +    :ref:`h264`. For further documentation, refer to the above=0A=
> +    specification, unless there is an explicit comment stating=0A=
> +    otherwise.=0A=
> +=0A=
> +    .. note::=0A=
> +=0A=
> +       This compound control is not yet part of the public kernel API an=
d=0A=
> +       it is expected to change.=0A=
> +=0A=
> +.. c:type:: v4l2_ctrl_h264_decode_param=0A=
> +=0A=
> +.. cssclass:: longtable=0A=
> +=0A=
> +.. flat-table:: struct v4l2_ctrl_h264_decode_param=0A=
> +    :header-rows:  0=0A=
> +    :stub-columns: 0=0A=
> +    :widths:       1 1 2=0A=
> +=0A=
> +    * - __u32=0A=
> +      - ``num_slices``=0A=
> +      - Number of slices needed to decode the current frame=0A=
> +    * - __u32=0A=
> +      - ``nal_ref_idc``=0A=
> +      - NAL reference ID value coming from the NAL Unit header=0A=
> +    * - __u8=0A=
> +      - ``ref_pic_list_p0[32]``=0A=
> +      - Backward reference list used by P-frames in the original bitstre=
am order=0A=
> +    * - __u8=0A=
> +      - ``ref_pic_list_b0[32]``=0A=
> +      - Backward reference list used by B-frames in the original bitstre=
am order=0A=
> +    * - __u8=0A=
> +      - ``ref_pic_list_b1[32]``=0A=
> +      - Forward reference list used by B-frames in the original bitstrea=
m order=0A=
> +    * - __s32=0A=
> +      - ``top_field_order_cnt``=0A=
> +      - Picture Order Count for the coded top field=0A=
> +    * - __s32=0A=
> +      - ``bottom_field_order_cnt``=0A=
> +      - Picture Order Count for the coded bottom field=0A=
> +    * - __u32=0A=
> +      - ``flags``=0A=
> +      - See :ref:`Decode Parameters Flags <h264_decode_params_flags>`=0A=
> +    * - struct :c:type:`v4l2_h264_dpb_entry`=0A=
> +      - ``dpb[16]``=0A=
> +      -=0A=
> +=0A=
> +.. _h264_decode_params_flags:=0A=
> +=0A=
> +``Decode Parameters Flags``=0A=
> +=0A=
> +.. cssclass:: longtable=0A=
> +=0A=
> +.. flat-table::=0A=
> +    :header-rows:  0=0A=
> +    :stub-columns: 0=0A=
> +    :widths:       1 1 2=0A=
> +=0A=
> +    * - ``V4L2_H264_DECODE_PARAM_FLAG_IDR_PIC``=0A=
> +      - 0x00000001=0A=
> +      - That picture is an IDR picture=0A=
> +=0A=
> +.. c:type:: v4l2_h264_dpb_entry=0A=
> +=0A=
> +.. cssclass:: longtable=0A=
> +=0A=
> +.. flat-table:: struct v4l2_h264_dpb_entry=0A=
> +    :header-rows:  0=0A=
> +    :stub-columns: 0=0A=
> +    :widths:       1 1 2=0A=
> +=0A=
> +    * - __u64=0A=
> +      - ``reference_ts``=0A=
> +      - Timestamp of the V4L2 capture buffer to use as reference, used=
=0A=
> +        with B-coded and P-coded frames. The timestamp refers to the=0A=
> +	``timestamp`` field in struct :c:type:`v4l2_buffer`. Use the=0A=
> +	:c:func:`v4l2_timeval_to_ns()` function to convert the struct=0A=
> +	:c:type:`timeval` in struct :c:type:`v4l2_buffer` to a __u64.=0A=
> +    * - __u16=0A=
> +      - ``frame_num``=0A=
> +      -=0A=
> +    * - __u16=0A=
> +      - ``pic_num``=0A=
> +      -=0A=
> +    * - __s32=0A=
> +      - ``top_field_order_cnt``=0A=
> +      -=0A=
> +    * - __s32=0A=
> +      - ``bottom_field_order_cnt``=0A=
> +      -=0A=
> +    * - __u32=0A=
> +      - ``flags``=0A=
> +      - See :ref:`DPB Entry Flags <h264_dpb_flags>`=0A=
> +=0A=
> +.. _h264_dpb_flags:=0A=
> +=0A=
> +``DPB Entries Flags``=0A=
> +=0A=
> +.. cssclass:: longtable=0A=
> +=0A=
> +.. flat-table::=0A=
> +    :header-rows:  0=0A=
> +    :stub-columns: 0=0A=
> +    :widths:       1 1 2=0A=
> +=0A=
> +    * - ``V4L2_H264_DPB_ENTRY_FLAG_VALID``=0A=
> +      - 0x00000001=0A=
> +      - The DPB entry is valid and should be considered=0A=
> +    * - ``V4L2_H264_DPB_ENTRY_FLAG_ACTIVE``=0A=
> +      - 0x00000002=0A=
> +      - The DPB entry is currently being used as a reference frame=0A=
> +    * - ``V4L2_H264_DPB_ENTRY_FLAG_LONG_TERM``=0A=
> +      - 0x00000004=0A=
> +      - The DPB entry is a long term reference frame=0A=
>  =0A=
>  .. _v4l2-mpeg-mpeg2:=0A=
>  =0A=
> diff --git a/Documentation/media/uapi/v4l/pixfmt-compressed.rst b/Documen=
tation/media/uapi/v4l/pixfmt-compressed.rst=0A=
> index 6c961cfb74da..ea0a8a68759b 100644=0A=
> --- a/Documentation/media/uapi/v4l/pixfmt-compressed.rst=0A=
> +++ b/Documentation/media/uapi/v4l/pixfmt-compressed.rst=0A=
> @@ -52,6 +52,25 @@ Compressed Formats=0A=
>        - ``V4L2_PIX_FMT_H264_MVC``=0A=
>        - 'M264'=0A=
>        - H264 MVC video elementary stream.=0A=
> +    * .. _V4L2-PIX-FMT-H264-SLICE:=0A=
> +=0A=
> +      - ``V4L2_PIX_FMT_H264_SLICE_RAW``=0A=
> +      - 'S264'=0A=
> +      - H264 parsed slice data, as extracted from the H264 bitstream.=0A=
> +	This format is adapted for stateless video decoders that=0A=
> +	implement an H264 pipeline (using the :ref:`codec` and=0A=
> +	:ref:`media-request-api`).  Metadata associated with the frame=0A=
> +	to decode are required to be passed through the=0A=
> +	``V4L2_CID_MPEG_VIDEO_H264_SPS``,=0A=
> +	``V4L2_CID_MPEG_VIDEO_H264_PPS``,=0A=
> +	``V4L2_CID_MPEG_VIDEO_H264_SCALING_MATRIX``,=0A=
> +	``V4L2_CID_MPEG_VIDEO_H264_SLICE_PARAMS`` and=0A=
> +	``V4L2_CID_MPEG_VIDEO_H264_DECODE_PARAMS`` controls.  See the=0A=
> +	:ref:`associated Codec Control IDs <v4l2-mpeg-h264>`.=0A=
> +	Exactly one output and one capture buffer must be provided for=0A=
> +	use with this pixel format. The output buffer must contain the=0A=
> +	appropriate number of macroblocks to decode a full=0A=
> +	corresponding frame to the matching capture buffer.=0A=
>      * .. _V4L2-PIX-FMT-H263:=0A=
>  =0A=
>        - ``V4L2_PIX_FMT_H263``=0A=
> diff --git a/Documentation/media/uapi/v4l/vidioc-queryctrl.rst b/Document=
ation/media/uapi/v4l/vidioc-queryctrl.rst=0A=
> index f824162d0ea9..bf29dc5b9758 100644=0A=
> --- a/Documentation/media/uapi/v4l/vidioc-queryctrl.rst=0A=
> +++ b/Documentation/media/uapi/v4l/vidioc-queryctrl.rst=0A=
> @@ -443,6 +443,36 @@ See also the examples in :ref:`control`.=0A=
>        - n/a=0A=
>        - A struct :c:type:`v4l2_ctrl_mpeg2_quantization`, containing MPEG=
-2=0A=
>  	quantization matrices for stateless video decoders.=0A=
> +    * - ``V4L2_CTRL_TYPE_H264_SPS``=0A=
> +      - n/a=0A=
> +      - n/a=0A=
> +      - n/a=0A=
> +      - A struct :c:type:`v4l2_ctrl_h264_sps`, containing H264=0A=
> +	sequence parameters for stateless video decoders.=0A=
> +    * - ``V4L2_CTRL_TYPE_H264_PPS``=0A=
> +      - n/a=0A=
> +      - n/a=0A=
> +      - n/a=0A=
> +      - A struct :c:type:`v4l2_ctrl_h264_pps`, containing H264=0A=
> +	picture parameters for stateless video decoders.=0A=
> +    * - ``V4L2_CTRL_TYPE_H264_SCALING_MATRIX``=0A=
> +      - n/a=0A=
> +      - n/a=0A=
> +      - n/a=0A=
> +      - A struct :c:type:`v4l2_ctrl_h264_scaling_matrix`, containing H26=
4=0A=
> +	scaling matrices for stateless video decoders.=0A=
> +    * - ``V4L2_CTRL_TYPE_H264_SLICE_PARAMS``=0A=
> +      - n/a=0A=
> +      - n/a=0A=
> +      - n/a=0A=
> +      - A struct :c:type:`v4l2_ctrl_h264_slice_param`, containing H264=
=0A=
> +	slice parameters for stateless video decoders.=0A=
> +    * - ``V4L2_CTRL_TYPE_H264_DECODE_PARAMS``=0A=
> +      - n/a=0A=
> +      - n/a=0A=
> +      - n/a=0A=
> +      - A struct :c:type:`v4l2_ctrl_h264_decode_param`, containing H264=
=0A=
> +	decode parameters for stateless video decoders.=0A=
>  =0A=
>  .. tabularcolumns:: |p{6.6cm}|p{2.2cm}|p{8.7cm}|=0A=
>  =0A=
> diff --git a/Documentation/media/videodev2.h.rst.exceptions b/Documentati=
on/media/videodev2.h.rst.exceptions=0A=
> index 64d348e67df9..55cbe324b9fc 100644=0A=
> --- a/Documentation/media/videodev2.h.rst.exceptions=0A=
> +++ b/Documentation/media/videodev2.h.rst.exceptions=0A=
> @@ -136,6 +136,11 @@ replace symbol V4L2_CTRL_TYPE_U32 :c:type:`v4l2_ctrl=
_type`=0A=
>  replace symbol V4L2_CTRL_TYPE_U8 :c:type:`v4l2_ctrl_type`=0A=
>  replace symbol V4L2_CTRL_TYPE_MPEG2_SLICE_PARAMS :c:type:`v4l2_ctrl_type=
`=0A=
>  replace symbol V4L2_CTRL_TYPE_MPEG2_QUANTIZATION :c:type:`v4l2_ctrl_type=
`=0A=
> +replace symbol V4L2_CTRL_TYPE_H264_SPS :c:type:`v4l2_ctrl_type`=0A=
> +replace symbol V4L2_CTRL_TYPE_H264_PPS :c:type:`v4l2_ctrl_type`=0A=
> +replace symbol V4L2_CTRL_TYPE_H264_SCALING_MATRIX :c:type:`v4l2_ctrl_typ=
e`=0A=
> +replace symbol V4L2_CTRL_TYPE_H264_SLICE_PARAMS :c:type:`v4l2_ctrl_type`=
=0A=
> +replace symbol V4L2_CTRL_TYPE_H264_DECODE_PARAMS :c:type:`v4l2_ctrl_type=
`=0A=
>  =0A=
>  # V4L2 capability defines=0A=
>  replace define V4L2_CAP_VIDEO_CAPTURE device-capabilities=0A=
> diff --git a/drivers/media/v4l2-core/v4l2-ctrls.c b/drivers/media/v4l2-co=
re/v4l2-ctrls.c=0A=
> index b1ae2e555c68..626bfcee3d55 100644=0A=
> --- a/drivers/media/v4l2-core/v4l2-ctrls.c=0A=
> +++ b/drivers/media/v4l2-core/v4l2-ctrls.c=0A=
> @@ -828,6 +828,11 @@ const char *v4l2_ctrl_get_name(u32 id)=0A=
>  	case V4L2_CID_MPEG_VIDEO_H264_CONSTRAINED_INTRA_PREDICTION:=0A=
>  								return "H264 Constrained Intra Pred";=0A=
>  	case V4L2_CID_MPEG_VIDEO_H264_CHROMA_QP_INDEX_OFFSET:	return "H264 Chro=
ma QP Index Offset";=0A=
> +	case V4L2_CID_MPEG_VIDEO_H264_SPS:			return "H264 Sequence Parameter Se=
t";=0A=
> +	case V4L2_CID_MPEG_VIDEO_H264_PPS:			return "H264 Picture Parameter Set=
";=0A=
> +	case V4L2_CID_MPEG_VIDEO_H264_SCALING_MATRIX:		return "H264 Scaling Mat=
rix";=0A=
> +	case V4L2_CID_MPEG_VIDEO_H264_SLICE_PARAMS:		return "H264 Slice Paramet=
ers";=0A=
> +	case V4L2_CID_MPEG_VIDEO_H264_DECODE_PARAMS:		return "H264 Decode Param=
eters";=0A=
>  	case V4L2_CID_MPEG_VIDEO_MPEG4_I_FRAME_QP:		return "MPEG4 I-Frame QP Va=
lue";=0A=
>  	case V4L2_CID_MPEG_VIDEO_MPEG4_P_FRAME_QP:		return "MPEG4 P-Frame QP Va=
lue";=0A=
>  	case V4L2_CID_MPEG_VIDEO_MPEG4_B_FRAME_QP:		return "MPEG4 B-Frame QP Va=
lue";=0A=
> @@ -1309,6 +1314,21 @@ void v4l2_ctrl_fill(u32 id, const char **name, enu=
m v4l2_ctrl_type *type,=0A=
>  	case V4L2_CID_MPEG_VIDEO_FWHT_PARAMS:=0A=
>  		*type =3D V4L2_CTRL_TYPE_FWHT_PARAMS;=0A=
>  		break;=0A=
> +	case V4L2_CID_MPEG_VIDEO_H264_SPS:=0A=
> +		*type =3D V4L2_CTRL_TYPE_H264_SPS;=0A=
> +		break;=0A=
> +	case V4L2_CID_MPEG_VIDEO_H264_PPS:=0A=
> +		*type =3D V4L2_CTRL_TYPE_H264_PPS;=0A=
> +		break;=0A=
> +	case V4L2_CID_MPEG_VIDEO_H264_SCALING_MATRIX:=0A=
> +		*type =3D V4L2_CTRL_TYPE_H264_SCALING_MATRIX;=0A=
> +		break;=0A=
> +	case V4L2_CID_MPEG_VIDEO_H264_SLICE_PARAMS:=0A=
> +		*type =3D V4L2_CTRL_TYPE_H264_SLICE_PARAMS;=0A=
> +		break;=0A=
> +	case V4L2_CID_MPEG_VIDEO_H264_DECODE_PARAMS:=0A=
> +		*type =3D V4L2_CTRL_TYPE_H264_DECODE_PARAMS;=0A=
> +		break;=0A=
>  	default:=0A=
>  		*type =3D V4L2_CTRL_TYPE_INTEGER;=0A=
>  		break;=0A=
> @@ -1678,6 +1698,13 @@ static int std_validate(const struct v4l2_ctrl *ct=
rl, u32 idx,=0A=
>  	case V4L2_CTRL_TYPE_FWHT_PARAMS:=0A=
>  		return 0;=0A=
>  =0A=
> +	case V4L2_CTRL_TYPE_H264_SPS:=0A=
> +	case V4L2_CTRL_TYPE_H264_PPS:=0A=
> +	case V4L2_CTRL_TYPE_H264_SCALING_MATRIX:=0A=
> +	case V4L2_CTRL_TYPE_H264_SLICE_PARAMS:=0A=
> +	case V4L2_CTRL_TYPE_H264_DECODE_PARAMS:=0A=
> +		return 0;=0A=
> +=0A=
>  	default:=0A=
>  		return -EINVAL;=0A=
>  	}=0A=
> @@ -2261,6 +2288,21 @@ static struct v4l2_ctrl *v4l2_ctrl_new(struct v4l2=
_ctrl_handler *hdl,=0A=
>  	case V4L2_CTRL_TYPE_FWHT_PARAMS:=0A=
>  		elem_size =3D sizeof(struct v4l2_ctrl_fwht_params);=0A=
>  		break;=0A=
> +	case V4L2_CTRL_TYPE_H264_SPS:=0A=
> +		elem_size =3D sizeof(struct v4l2_ctrl_h264_sps);=0A=
> +		break;=0A=
> +	case V4L2_CTRL_TYPE_H264_PPS:=0A=
> +		elem_size =3D sizeof(struct v4l2_ctrl_h264_pps);=0A=
> +		break;=0A=
> +	case V4L2_CTRL_TYPE_H264_SCALING_MATRIX:=0A=
> +		elem_size =3D sizeof(struct v4l2_ctrl_h264_scaling_matrix);=0A=
> +		break;=0A=
> +	case V4L2_CTRL_TYPE_H264_SLICE_PARAMS:=0A=
> +		elem_size =3D sizeof(struct v4l2_ctrl_h264_slice_param);=0A=
> +		break;=0A=
> +	case V4L2_CTRL_TYPE_H264_DECODE_PARAMS:=0A=
> +		elem_size =3D sizeof(struct v4l2_ctrl_h264_decode_param);=0A=
> +		break;=0A=
>  	default:=0A=
>  		if (type < V4L2_CTRL_COMPOUND_TYPES)=0A=
>  			elem_size =3D sizeof(s32);=0A=
> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-co=
re/v4l2-ioctl.c=0A=
> index ac87c3e37280..f6e1254064d2 100644=0A=
> --- a/drivers/media/v4l2-core/v4l2-ioctl.c=0A=
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c=0A=
> @@ -1325,6 +1325,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *f=
mt)=0A=
>  		case V4L2_PIX_FMT_H264:		descr =3D "H.264"; break;=0A=
>  		case V4L2_PIX_FMT_H264_NO_SC:	descr =3D "H.264 (No Start Codes)"; brea=
k;=0A=
>  		case V4L2_PIX_FMT_H264_MVC:	descr =3D "H.264 MVC"; break;=0A=
> +		case V4L2_PIX_FMT_H264_SLICE_RAW:	descr =3D "H.264 Parsed Slice Data";=
 break;=0A=
>  		case V4L2_PIX_FMT_H263:		descr =3D "H.263"; break;=0A=
>  		case V4L2_PIX_FMT_MPEG1:	descr =3D "MPEG-1 ES"; break;=0A=
>  		case V4L2_PIX_FMT_MPEG2:	descr =3D "MPEG-2 ES"; break;=0A=
> diff --git a/include/media/h264-ctrls.h b/include/media/h264-ctrls.h=0A=
> new file mode 100644=0A=
> index 000000000000..a086ed6ee91f=0A=
> --- /dev/null=0A=
> +++ b/include/media/h264-ctrls.h=0A=
> @@ -0,0 +1,192 @@=0A=
> +/* SPDX-License-Identifier: GPL-2.0 */=0A=
> +/*=0A=
> + * These are the H.264 state controls for use with stateless H.264=0A=
> + * codec drivers.=0A=
> + *=0A=
> + * It turns out that these structs are not stable yet and will undergo=
=0A=
> + * more changes. So keep them private until they are stable and ready to=
=0A=
> + * become part of the official public API.=0A=
> + */=0A=
> +=0A=
> +#ifndef _H264_CTRLS_H_=0A=
> +#define _H264_CTRLS_H_=0A=
> +=0A=
> +/*=0A=
> + * This is put insanely high to avoid conflicting with controls that=0A=
> + * would be added during the phase where those controls are not=0A=
> + * stable. It should be fixed eventually.=0A=
> + */=0A=
> +#define V4L2_CID_MPEG_VIDEO_H264_SPS		(V4L2_CID_MPEG_BASE+1000)=0A=
> +#define V4L2_CID_MPEG_VIDEO_H264_PPS		(V4L2_CID_MPEG_BASE+1001)=0A=
> +#define V4L2_CID_MPEG_VIDEO_H264_SCALING_MATRIX	(V4L2_CID_MPEG_BASE+1002=
)=0A=
> +#define V4L2_CID_MPEG_VIDEO_H264_SLICE_PARAMS	(V4L2_CID_MPEG_BASE+1003)=
=0A=
> +#define V4L2_CID_MPEG_VIDEO_H264_DECODE_PARAMS	(V4L2_CID_MPEG_BASE+1004)=
=0A=
> +=0A=
> +/* enum v4l2_ctrl_type type values */=0A=
> +#define V4L2_CTRL_TYPE_H264_SPS			0x0110=0A=
> +#define V4L2_CTRL_TYPE_H264_PPS			0x0111=0A=
> +#define V4L2_CTRL_TYPE_H264_SCALING_MATRIX	0x0112=0A=
> +#define V4L2_CTRL_TYPE_H264_SLICE_PARAMS	0x0113=0A=
> +#define V4L2_CTRL_TYPE_H264_DECODE_PARAMS	0x0114=0A=
> +=0A=
> +#define V4L2_H264_SPS_CONSTRAINT_SET0_FLAG			0x01=0A=
> +#define V4L2_H264_SPS_CONSTRAINT_SET1_FLAG			0x02=0A=
> +#define V4L2_H264_SPS_CONSTRAINT_SET2_FLAG			0x04=0A=
> +#define V4L2_H264_SPS_CONSTRAINT_SET3_FLAG			0x08=0A=
> +#define V4L2_H264_SPS_CONSTRAINT_SET4_FLAG			0x10=0A=
> +#define V4L2_H264_SPS_CONSTRAINT_SET5_FLAG			0x20=0A=
> +=0A=
> +#define V4L2_H264_SPS_FLAG_SEPARATE_COLOUR_PLANE		0x01=0A=
> +#define V4L2_H264_SPS_FLAG_QPPRIME_Y_ZERO_TRANSFORM_BYPASS	0x02=0A=
> +#define V4L2_H264_SPS_FLAG_DELTA_PIC_ORDER_ALWAYS_ZERO		0x04=0A=
> +#define V4L2_H264_SPS_FLAG_GAPS_IN_FRAME_NUM_VALUE_ALLOWED	0x08=0A=
> +#define V4L2_H264_SPS_FLAG_FRAME_MBS_ONLY			0x10=0A=
> +#define V4L2_H264_SPS_FLAG_MB_ADAPTIVE_FRAME_FIELD		0x20=0A=
> +#define V4L2_H264_SPS_FLAG_DIRECT_8X8_INFERENCE			0x40=0A=
> +=0A=
> +struct v4l2_ctrl_h264_sps {=0A=
> +	__u8 profile_idc;=0A=
> +	__u8 constraint_set_flags;=0A=
> +	__u8 level_idc;=0A=
> +	__u8 seq_parameter_set_id;=0A=
> +	__u8 chroma_format_idc;=0A=
> +	__u8 bit_depth_luma_minus8;=0A=
> +	__u8 bit_depth_chroma_minus8;=0A=
> +	__u8 log2_max_frame_num_minus4;=0A=
> +	__u8 pic_order_cnt_type;=0A=
> +	__u8 log2_max_pic_order_cnt_lsb_minus4;=0A=
> +	__u8 max_num_ref_frames;=0A=
> +	__u8 num_ref_frames_in_pic_order_cnt_cycle;=0A=
> +	__s32 offset_for_ref_frame[255];=0A=
> +	__s32 offset_for_non_ref_pic;=0A=
> +	__s32 offset_for_top_to_bottom_field;=0A=
> +	__u16 pic_width_in_mbs_minus1;=0A=
> +	__u16 pic_height_in_map_units_minus1;=0A=
> +	__u32 flags;=0A=
> +};=0A=
> +=0A=
> +#define V4L2_H264_PPS_FLAG_ENTROPY_CODING_MODE				0x0001=0A=
> +#define V4L2_H264_PPS_FLAG_BOTTOM_FIELD_PIC_ORDER_IN_FRAME_PRESENT	0x000=
2=0A=
> +#define V4L2_H264_PPS_FLAG_WEIGHTED_PRED				0x0004=0A=
> +#define V4L2_H264_PPS_FLAG_DEBLOCKING_FILTER_CONTROL_PRESENT		0x0008=0A=
> +#define V4L2_H264_PPS_FLAG_CONSTRAINED_INTRA_PRED			0x0010=0A=
> +#define V4L2_H264_PPS_FLAG_REDUNDANT_PIC_CNT_PRESENT			0x0020=0A=
> +#define V4L2_H264_PPS_FLAG_TRANSFORM_8X8_MODE				0x0040=0A=
> +#define V4L2_H264_PPS_FLAG_PIC_SCALING_MATRIX_PRESENT			0x0080=0A=
> +=0A=
> +struct v4l2_ctrl_h264_pps {=0A=
> +	__u8 pic_parameter_set_id;=0A=
> +	__u8 seq_parameter_set_id;=0A=
> +	__u8 num_slice_groups_minus1;=0A=
> +	__u8 num_ref_idx_l0_default_active_minus1;=0A=
> +	__u8 num_ref_idx_l1_default_active_minus1;=0A=
> +	__u8 weighted_bipred_idc;=0A=
> +	__s8 pic_init_qp_minus26;=0A=
> +	__s8 pic_init_qs_minus26;=0A=
> +	__s8 chroma_qp_index_offset;=0A=
> +	__s8 second_chroma_qp_index_offset;=0A=
> +	__u16 flags;=0A=
> +};=0A=
> +=0A=
> +struct v4l2_ctrl_h264_scaling_matrix {=0A=
> +	__u8 scaling_list_4x4[6][16];=0A=
> +	__u8 scaling_list_8x8[6][64];=0A=
> +};=0A=
> +=0A=
> +struct v4l2_h264_weight_factors {=0A=
> +	__s16 luma_weight[32];=0A=
> +	__s16 luma_offset[32];=0A=
> +	__s16 chroma_weight[32][2];=0A=
> +	__s16 chroma_offset[32][2];=0A=
> +};=0A=
> +=0A=
> +struct v4l2_h264_pred_weight_table {=0A=
> +	__u16 luma_log2_weight_denom;=0A=
> +	__u16 chroma_log2_weight_denom;=0A=
> +	struct v4l2_h264_weight_factors weight_factors[2];=0A=
> +};=0A=
> +=0A=
> +#define V4L2_H264_SLICE_TYPE_P				0=0A=
> +#define V4L2_H264_SLICE_TYPE_B				1=0A=
> +#define V4L2_H264_SLICE_TYPE_I				2=0A=
> +#define V4L2_H264_SLICE_TYPE_SP				3=0A=
> +#define V4L2_H264_SLICE_TYPE_SI				4=0A=
> +=0A=
> +#define V4L2_H264_SLICE_FLAG_FIELD_PIC			0x01=0A=
> +#define V4L2_H264_SLICE_FLAG_BOTTOM_FIELD		0x02=0A=
> +#define V4L2_H264_SLICE_FLAG_DIRECT_SPATIAL_MV_PRED	0x04=0A=
> +#define V4L2_H264_SLICE_FLAG_SP_FOR_SWITCH		0x08=0A=
> +=0A=
> +struct v4l2_ctrl_h264_slice_param {=0A=
> +	/* Size in bytes, including header */=0A=
> +	__u32 size;=0A=
> +	/* Offset in bits to slice_data() from the beginning of this slice. */=
=0A=
> +	__u32 header_bit_size;=0A=
> +=0A=
> +	__u16 first_mb_in_slice;=0A=
> +	__u8 slice_type;=0A=
> +	__u8 pic_parameter_set_id;=0A=
> +	__u8 colour_plane_id;=0A=
> +	__u8 redundant_pic_cnt;=0A=
> +	__u16 frame_num;=0A=
> +	__u16 idr_pic_id;=0A=
> +	__u16 pic_order_cnt_lsb;=0A=
> +	__s32 delta_pic_order_cnt_bottom;=0A=
> +	__s32 delta_pic_order_cnt0;=0A=
> +	__s32 delta_pic_order_cnt1;=0A=
> +=0A=
> +	struct v4l2_h264_pred_weight_table pred_weight_table;=0A=
> +	/* Size in bits of dec_ref_pic_marking() syntax element. */=0A=
> +	__u32 dec_ref_pic_marking_bit_size;=0A=
> +	/* Size in bits of pic order count syntax. */=0A=
> +	__u32 pic_order_cnt_bit_size;=0A=
> +=0A=
> +	__u8 cabac_init_idc;=0A=
> +	__s8 slice_qp_delta;=0A=
> +	__s8 slice_qs_delta;=0A=
> +	__u8 disable_deblocking_filter_idc;=0A=
> +	__s8 slice_alpha_c0_offset_div2;=0A=
> +	__s8 slice_beta_offset_div2;=0A=
> +	__u8 num_ref_idx_l0_active_minus1;=0A=
> +	__u8 num_ref_idx_l1_active_minus1;=0A=
> +	__u32 slice_group_change_cycle;=0A=
> +=0A=
> +	/*=0A=
> +	 * Entries on each list are indices into=0A=
> +	 * v4l2_ctrl_h264_decode_param.dpb[].=0A=
> +	 */=0A=
> +	__u8 ref_pic_list0[32];=0A=
> +	__u8 ref_pic_list1[32];=0A=
> +=0A=
> +	__u32 flags;=0A=
> +};=0A=
> +=0A=
> +#define V4L2_H264_DPB_ENTRY_FLAG_VALID		0x01=0A=
> +#define V4L2_H264_DPB_ENTRY_FLAG_ACTIVE		0x02=0A=
> +#define V4L2_H264_DPB_ENTRY_FLAG_LONG_TERM	0x04=0A=
> +=0A=
> +struct v4l2_h264_dpb_entry {=0A=
> +	__u64 reference_ts;=0A=
> +	__u16 frame_num;=0A=
> +	__u16 pic_num;=0A=
> +	/* Note that field is indicated by v4l2_buffer.field */=0A=
> +	__s32 top_field_order_cnt;=0A=
> +	__s32 bottom_field_order_cnt;=0A=
> +	__u32 flags; /* V4L2_H264_DPB_ENTRY_FLAG_* */=0A=
> +};=0A=
> +=0A=
> +#define V4L2_H264_DECODE_PARAM_FLAG_IDR_PIC	0x01=0A=
> +=0A=
> +struct v4l2_ctrl_h264_decode_param {=0A=
> +	struct v4l2_h264_dpb_entry dpb[16];=0A=
> +	__u16 num_slices;=0A=
> +	__u16 nal_ref_idc;=0A=
> +	__u8 ref_pic_list_p0[32];=0A=
> +	__u8 ref_pic_list_b0[32];=0A=
> +	__u8 ref_pic_list_b1[32];=0A=
> +	__s32 top_field_order_cnt;=0A=
> +	__s32 bottom_field_order_cnt;=0A=
> +	__u32 flags; /* V4L2_H264_DECODE_PARAM_FLAG_* */=0A=
> +};=0A=
> +=0A=
> +#endif=0A=
> diff --git a/include/media/v4l2-ctrls.h b/include/media/v4l2-ctrls.h=0A=
> index bd621cec65a5..4cd1ddbc6289 100644=0A=
> --- a/include/media/v4l2-ctrls.h=0A=
> +++ b/include/media/v4l2-ctrls.h=0A=
> @@ -23,11 +23,12 @@=0A=
>  #include <media/media-request.h>=0A=
>  =0A=
>  /*=0A=
> - * Include the mpeg2 and fwht stateless codec compound control definitio=
ns.=0A=
> + * Include the stateless codec compound control definitions.=0A=
>   * This will move to the public headers once this API is fully stable.=
=0A=
>   */=0A=
>  #include <media/mpeg2-ctrls.h>=0A=
>  #include <media/fwht-ctrls.h>=0A=
> +#include <media/h264-ctrls.h>=0A=
>  =0A=
>  /* forward references */=0A=
>  struct file;=0A=
> @@ -51,6 +52,11 @@ struct poll_table_struct;=0A=
>   * @p_mpeg2_slice_params:	Pointer to a MPEG2 slice parameters structure.=
=0A=
>   * @p_mpeg2_quantization:	Pointer to a MPEG2 quantization data structure=
.=0A=
>   * @p_fwht_params:		Pointer to a FWHT stateless parameters structure.=0A=
> + * @p_h264_sps:			Pointer to a struct v4l2_ctrl_h264_sps.=0A=
> + * @p_h264_pps:			Pointer to a struct v4l2_ctrl_h264_pps.=0A=
> + * @p_h264_scaling_matrix:	Pointer to a struct v4l2_ctrl_h264_scaling_ma=
trix.=0A=
> + * @p_h264_slice_param:		Pointer to a struct v4l2_ctrl_h264_slice_param.=
=0A=
> + * @p_h264_decode_param:	Pointer to a struct v4l2_ctrl_h264_decode_param=
.=0A=
>   * @p:				Pointer to a compound value.=0A=
>   */=0A=
>  union v4l2_ctrl_ptr {=0A=
> @@ -63,6 +69,11 @@ union v4l2_ctrl_ptr {=0A=
>  	struct v4l2_ctrl_mpeg2_slice_params *p_mpeg2_slice_params;=0A=
>  	struct v4l2_ctrl_mpeg2_quantization *p_mpeg2_quantization;=0A=
>  	struct v4l2_ctrl_fwht_params *p_fwht_params;=0A=
> +	struct v4l2_ctrl_h264_sps *p_h264_sps;=0A=
> +	struct v4l2_ctrl_h264_pps *p_h264_pps;=0A=
> +	struct v4l2_ctrl_h264_scaling_matrix *p_h264_scaling_matrix;=0A=
> +	struct v4l2_ctrl_h264_slice_param *p_h264_slice_param;=0A=
> +	struct v4l2_ctrl_h264_decode_param *p_h264_decode_param;=0A=
>  	void *p;=0A=
>  };=0A=
>  =0A=
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev=
2.h=0A=
> index 496e6453450c..838732acdefc 100644=0A=
> --- a/include/uapi/linux/videodev2.h=0A=
> +++ b/include/uapi/linux/videodev2.h=0A=
> @@ -657,6 +657,7 @@ struct v4l2_pix_format {=0A=
>  #define V4L2_PIX_FMT_H264     v4l2_fourcc('H', '2', '6', '4') /* H264 wi=
th start codes */=0A=
>  #define V4L2_PIX_FMT_H264_NO_SC v4l2_fourcc('A', 'V', 'C', '1') /* H264 =
without start codes */=0A=
>  #define V4L2_PIX_FMT_H264_MVC v4l2_fourcc('M', '2', '6', '4') /* H264 MV=
C */=0A=
> +#define V4L2_PIX_FMT_H264_SLICE_RAW v4l2_fourcc('S', '2', '6', '4') /* H=
264 parsed slices */=0A=
>  #define V4L2_PIX_FMT_H263     v4l2_fourcc('H', '2', '6', '3') /* H263   =
       */=0A=
>  #define V4L2_PIX_FMT_MPEG1    v4l2_fourcc('M', 'P', 'G', '1') /* MPEG-1 =
ES     */=0A=
>  #define V4L2_PIX_FMT_MPEG2    v4l2_fourcc('M', 'P', 'G', '2') /* MPEG-2 =
ES     */=0A=
> =0A=
=0A=
